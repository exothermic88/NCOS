#!/bin/bash

# theme-lib.sh — shared helpers for theme-select.sh, wallselect.sh and
# wallcycle.sh
# awww is the sole owner of the wallpaper; cosmic-bg is never written to.

AWWW_STAMP="$HOME/.cache/awww-last-set"
THEMES_BASE="$HOME/.config/themes"
DUAL_CACHE="$HOME/.cache/awww-dual"

# The only cosmic dirs that are theme-specific; everything else is shared
# live config and never moves on a theme switch.
THEME_COSMIC_DIRS=(
    com.system76.CosmicTheme.Dark
    com.system76.CosmicTheme.Dark.Builder
    com.system76.CosmicTheme.Light
    com.system76.CosmicTheme.Light.Builder
    com.system76.CosmicTheme.Mode
)

get_current_theme() { cat "$HOME/.current_theme" 2>/dev/null || echo nord; }
theme_wall_dir()    { echo "$HOME/.config/wallpapers/$1"; }
wallpaper_theme()   { basename "$(dirname "$1")"; }

# Panoramas meant to span all monitors are marked by "dual" in the
# filename; everything else repeats per monitor as usual.
is_dual_wallpaper() {
    local name
    name=$(basename "$1")
    [[ "${name,,}" == *dual* ]]
}

# All wallpapers across every theme folder, full paths, sorted so they
# group by theme folder.
list_all_wallpapers() {
    find "$HOME/.config/wallpapers" -mindepth 2 -maxdepth 2 -type f \
        \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) \
        2>/dev/null | sort
}

# Enabled outputs as "x y width height name" lines sorted left-to-right,
# geometry taken from cosmic-randr's current mode. Prints nothing when
# cosmic-randr is unavailable, in which case dual splitting is skipped.
list_outputs_lr() {
    cosmic-randr list 2>/dev/null \
        | sed 's/\x1b\[[0-9;]*m//g' \
        | awk '
            /^[^ ].*\(enabled\)/ { name = $1 }
            /^  Position:/       { split($2, p, ","); x = p[1]; y = p[2] }
            /\(current\)/ && name != "" {
                split($1, m, "x")
                print x, y, m[1], m[2], name
                name = ""
            }' \
        | sort -n -k1,1
}

# split_dual_wallpaper <img> — cut a panorama into one tile per output,
# scaled to cover the combined monitor area. Tiles are cached under
# DUAL_CACHE keyed on image path+mtime+layout. Prints "name<TAB>tile"
# lines; fails without output when there are fewer than 2 outputs or a
# tile cannot be produced (caller then falls back to per-monitor).
split_dual_wallpaper() {
    local img="$1" outputs key
    outputs=$(list_outputs_lr)
    [ "$(grep -c . <<< "$outputs")" -ge 2 ] || return 1

    key=$(printf '%s|%s|%s' "$img" "$(stat -c %Y "$img" 2>/dev/null)" "$outputs" \
        | md5sum | cut -d' ' -f1)
    mkdir -p "$DUAL_CACHE"

    # Bounding box of all outputs = the canvas the panorama must cover.
    local minx miny W H
    read -r minx miny W H < <(awk '
        NR == 1 { minx = $1; miny = $2; maxx = $1 + $3; maxy = $2 + $4; next }
        { if ($1 < minx) minx = $1
          if ($2 < miny) miny = $2
          if ($1 + $3 > maxx) maxx = $1 + $3
          if ($2 + $4 > maxy) maxy = $2 + $4 }
        END { print minx, miny, maxx - minx, maxy - miny }' <<< "$outputs")

    local x y w h name tile
    while read -r x y w h name; do
        tile="$DUAL_CACHE/$key-$name.png"
        if [ ! -f "$tile" ]; then
            magick "$img" \
                -resize "${W}x${H}^" -gravity center -extent "${W}x${H}" \
                +gravity -crop "${w}x${h}+$((x - minx))+$((y - miny))" +repage \
                "$tile" 2>/dev/null || return 1
        fi
        printf '%s\t%s\n' "$name" "$tile"
    done <<< "$outputs"
}

# While the daemon is down, cosmic-bg's wallpaper shows through — sync its
# configured image to what awww is currently showing first, so the restart
# window is pixel-identical and invisible.
restart_awww() {
    local cur
    cur=$(cat "$THEMES_BASE/$(get_current_theme)/.current_wallpaper" 2>/dev/null)
    if [ -f "$cur" ]; then
        sed -i "s|source: Path(\"[^\"]*\")|source: Path(\"$cur\")|" \
            "$HOME/.config/cosmic/com.system76.CosmicBackground/v1/all" 2>/dev/null
    fi
    awww kill 2>/dev/null || pkill -x awww-daemon
    sleep 0.3
    awww-daemon >/dev/null 2>&1 &
    sleep 0.5
}

# cosmic-bg stacks its background surface over awww's whenever it redraws,
# i.e. when a wallpaper is picked in COSMIC Settings. (Theme changes don't
# trigger it: the live config has filter_by_theme: false.) If its config is
# newer than our last paint, awww is buried and the daemon must be restarted
# so its new surface is created last and ends up on top.
awww_needs_heal() {
    pgrep -x awww-daemon >/dev/null || return 0
    [ -f "$AWWW_STAMP" ] || return 0
    [ -n "$(find "$HOME/.config/cosmic/com.system76.CosmicBackground" \
                 -newer "$AWWW_STAMP" -print -quit 2>/dev/null)" ]
}

# backup_theme_configs <theme> — save the live theming configs (the
# THEME_COSMIC_DIRS subset of cosmic, kitty, VS Code) into a theme's folder
# so tweaks made while it was active are remembered.
backup_theme_configs() {
    local dir="$THEMES_BASE/$1" d
    mkdir -p "$dir/cosmic" "$dir/kitty" "$dir/code"
    for d in "${THEME_COSMIC_DIRS[@]}"; do
        [ -d "$HOME/.config/cosmic/$d" ] || continue
        cp -r "$HOME/.config/cosmic/$d" "$dir/cosmic/" 2>/dev/null
    done
    cp "$HOME"/.config/kitty/*.conf "$dir/kitty/" 2>/dev/null
    cp "$HOME/.config/Code/User/settings.json" "$dir/code/" 2>/dev/null
}

# restore_theme_configs <theme> — copy a theme's stored theming configs into
# the live locations (cosmic/kitty/VS Code). Only the THEME_COSMIC_DIRS
# subset of cosmic moves; awww owns the wallpaper. Restore only: the live
# config is NOT backed up first.
restore_theme_configs() {
    local dir="$THEMES_BASE/$1" d
    [ -d "$dir" ] || return 1
    mkdir -p "$HOME/.config/cosmic" "$HOME/.config/kitty" "$HOME/.config/Code/User"
    for d in "${THEME_COSMIC_DIRS[@]}"; do
        [ -d "$dir/cosmic/$d" ] || continue
        cp -r "$dir/cosmic/$d" "$HOME/.config/cosmic/" 2>/dev/null
    done
    cp "$dir"/kitty/*.conf "$HOME/.config/kitty/" 2>/dev/null
    cp "$dir/code/settings.json" "$HOME/.config/Code/User/" 2>/dev/null
    return 0
}

# switch_theme <theme> — back up the outgoing theme's theming configs,
# restore the incoming theme's, and update ~/.current_theme.
# Returns 0 on an actual switch, 1 if <theme> is already current (no-op),
# 2 if the theme directory is missing. Callers must switch BEFORE calling
# set_wallpaper so the wallpaper is recorded under the new theme.
switch_theme() {
    local new="$1" current
    current=$(get_current_theme)
    [ "$new" = "$current" ] && return 1
    [ -d "$THEMES_BASE/$new" ] || { echo "Theme directory not found: $THEMES_BASE/$new"; return 2; }
    backup_theme_configs "$current"
    restore_theme_configs "$new"
    echo "$new" > "$HOME/.current_theme"
    return 0
}

# set_wallpaper <path> [transition] [force]
# "*dual*" panoramas are split into per-output tiles so they span all
# monitors; state still records the original panorama path.
set_wallpaper() {
    local img="$1" trans="${2:-center}" theme tiles
    theme=$(get_current_theme)
    if [ "$3" = "force" ] || awww_needs_heal; then
        restart_awww
    fi
    if is_dual_wallpaper "$img" && tiles=$(split_dual_wallpaper "$img"); then
        local name tile pids=() rc=0
        while IFS=$'\t' read -r name tile; do
            awww img "$tile" -o "$name" \
                --transition-type "$trans" \
                --transition-step 90 \
                --transition-fps 60 &
            pids+=($!)
        done <<< "$tiles"
        for p in "${pids[@]}"; do wait "$p" || rc=1; done
        [ "$rc" -eq 0 ] || return 1
    else
        awww img "$img" \
            --transition-type "$trans" \
            --transition-step 90 \
            --transition-fps 60 || return 1
    fi
    mkdir -p "$(dirname "$AWWW_STAMP")" "$THEMES_BASE/$theme"
    touch "$AWWW_STAMP"
    printf '%s\n' "$img" > "$THEMES_BASE/$theme/.current_wallpaper"
}
