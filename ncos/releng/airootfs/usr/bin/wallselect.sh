#!/bin/bash

# wallselect.sh — pick a wallpaper from a rofi grid with thumbnail previews,
# across ALL themes (~/.config/wallpapers/<theme>/). Picking a wallpaper from
# another theme's folder switches to that theme (theming configs only).
# Login restore is still handled by wallcycle.sh restore.

source /usr/bin/theme-lib.sh

THEME=$(get_current_theme)

mapfile -t WALLPAPERS < <(list_all_wallpapers)

if [ "${#WALLPAPERS[@]}" -eq 0 ]; then
    echo "No wallpapers found in $HOME/.config/wallpapers"
    exit 1
fi

# Find current wallpaper so the picker opens on it: per-theme state file
# first (survives daemon restarts), awww query as fallback.
CURRENT=$(cat "$THEMES_BASE/$THEME/.current_wallpaper" 2>/dev/null)
if [ -z "$CURRENT" ]; then
    CURRENT=$(awww query 2>/dev/null \
        | grep -oE "currently displaying: image: .*" \
        | sed 's/currently displaying: image: //')
fi

# Locate it in the global list; if unknown, open on the current theme's
# first wallpaper rather than the globally first one.
CURRENT_INDEX=-1
for i in "${!WALLPAPERS[@]}"; do
    if [[ "${WALLPAPERS[$i]}" == "$CURRENT" ]]; then
        CURRENT_INDEX=$i
        break
    fi
done
if [ "$CURRENT_INDEX" -lt 0 ]; then
    CURRENT_INDEX=0
    for i in "${!WALLPAPERS[@]}"; do
        if [[ "$(wallpaper_theme "${WALLPAPERS[$i]}")" == "$THEME" ]]; then
            CURRENT_INDEX=$i
            break
        fi
    done
fi

# One row per wallpaper: "theme · name" label, full path as preview icon.
# -format i returns the row index, so filenames never need escaping.
CHOICE=$(for w in "${WALLPAPERS[@]}"; do
        name=$(basename "$w")
        printf '%s · %s\0icon\x1f%s\n' "$(wallpaper_theme "$w")" "${name%.*}" "$w"
    done | rofi -dmenu -i -show-icons -no-custom \
        -p "$THEME" \
        -theme "$HOME/.config/rofi/wallselect.rasi" \
        -selected-row "$CURRENT_INDEX" \
        -format i)

# Escape / closed without picking
[ -z "$CHOICE" ] && exit 0

WP="${WALLPAPERS[$CHOICE]}"

# Switch theme first — set_wallpaper records state under the current theme.
TRANSITION_TYPE="center"
if switch_theme "$(wallpaper_theme "$WP")"; then
    TRANSITION_TYPE="grow"
fi

set_wallpaper "$WP" "$TRANSITION_TYPE"
