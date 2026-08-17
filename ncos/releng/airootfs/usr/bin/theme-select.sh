#!/bin/bash

# theme-select.sh — switch to the next/previous theme.
# Usage: theme-select.sh [next|prev]   (default: next)
# Backs up the outgoing theme's theming configs, restores the incoming
# theme's (CosmicTheme.* + kitty + VS Code only), then applies the incoming
# theme's wallpaper via awww with a grow transition.

source /usr/bin/theme-lib.sh

themes=("nord" "red" "purple")
direction="${1:-next}"

current=$(get_current_theme)
echo "Current theme before change: $current"

# Determine the next theme
idx=0
for i in "${!themes[@]}"; do
    if [[ "${themes[$i]}" == "$current" ]]; then
        idx=$i
        break
    fi
done

count=${#themes[@]}
if [ "$direction" = "prev" ]; then
    next_idx=$(( (idx - 1 + count) % count ))
else
    next_idx=$(( (idx + 1) % count ))
fi

next="${themes[$next_idx]}"
next_dir="$THEMES_BASE/$next"

switch_theme "$next"
[ $? -eq 2 ] && exit 1

# Apply the theme's remembered wallpaper (or its first one) with a grow
# animation. cosmic-bg ignores theme changes (filter_by_theme: false in the
# live config), so no daemon restart is needed and the transition plays
# directly from the old theme's wallpaper.
wp=$(cat "$next_dir/.current_wallpaper" 2>/dev/null)
if [ ! -f "$wp" ]; then
    wp=$(find "$(theme_wall_dir "$next")" -maxdepth 1 -type f \
        \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) \
        2>/dev/null | sort | head -n1)
fi
if [ -n "$wp" ]; then
    set_wallpaper "$wp" grow
fi

echo "Switched to theme: $next"
