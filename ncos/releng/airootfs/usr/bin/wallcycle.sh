#!/bin/bash

# wallcycle.sh — cycle through ALL themes' wallpapers
# (~/.config/wallpapers/<theme>/), switching theme (theming configs only)
# when crossing into another theme's folder.
# Usage: wallcycle.sh            advance to the next wallpaper
#        wallcycle.sh restore    re-apply the saved wallpaper (login/heal)

source /usr/bin/theme-lib.sh

THEME=$(get_current_theme)

mapfile -t WALLPAPERS < <(list_all_wallpapers)

TOTAL_WALLS=${#WALLPAPERS[@]}
if [ "$TOTAL_WALLS" -eq 0 ]; then
    echo "No wallpapers found in $HOME/.config/wallpapers"
    exit 1
fi

# Find current wallpaper: per-theme state file first (survives daemon
# restarts), awww query as fallback.
CURRENT=$(cat "$THEMES_BASE/$THEME/.current_wallpaper" 2>/dev/null)
if [ -z "$CURRENT" ]; then
    CURRENT=$(awww query 2>/dev/null \
        | grep -oE "currently displaying: image: .*" \
        | sed 's/currently displaying: image: //')
fi

# Locate it in the global list; if unknown, fall back to the current
# theme's first wallpaper rather than the globally first one.
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

# restore mode: re-apply the current wallpaper without advancing or
# switching themes, no HUD
if [ "$1" = "restore" ]; then
    set_wallpaper "${WALLPAPERS[$CURRENT_INDEX]}" simple force
    exit $?
fi

NEXT_INDEX=$(( (CURRENT_INDEX + 1) % TOTAL_WALLS ))
WP="${WALLPAPERS[$NEXT_INDEX]}"

# Switch theme first — set_wallpaper records state under the current theme.
TRANSITION_TYPE="center"
if switch_theme "$(wallpaper_theme "$WP")"; then
    TRANSITION_TYPE="grow"
fi

set_wallpaper "$WP" "$TRANSITION_TYPE"
