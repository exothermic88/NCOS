#!/bin/bash

# Define the base themes directory
themes_base="/etc/NCOS/themes"
# List of theme directories
themes=("purple" "red" "nord")

# Temporary file to store the current theme
theme_file="/etc/NCOS/themes/.current_theme"

# Check if the theme file exists; if not, initialize it with "nord"
if [ ! -f "$theme_file" ]; then
    echo "nord" > "$theme_file"
fi

# Read the current theme from the file
current_theme_name=$(cat "$theme_file")
echo "Current theme before change: $current_theme_name"  # Debug

# Find the index of the current theme
current_index=-1
for i in "${!themes[@]}"; do
    if [[ "${themes[$i]}" == "$current_theme_name" ]]; then
        current_index=$i
        break
    fi
done

echo "Current index: $current_index"  # Debug

# Determine the next theme index
if [ $current_index -eq -1 ]; then
    next_index=0  # If the current theme is not found, default to the first theme
else
    next_index=$(( (current_index + 1) % ${#themes[@]} ))  # Cycle through themes
fi

echo "Next index: $next_index"  # Debug

# Change to the next theme directory
next_theme="${themes[$next_index]}"
cd "$themes_base/$next_theme" || { echo "Theme directory not found!"; exit 1; }

# Update the theme file with the new current theme
echo "$next_theme" > "$theme_file"

# Copy the relevant files to the config directory
cp -r com.system76.CosmicBackground ~/.config/cosmic/
cp -r com.system76.CosmicTheme.* ~/.config/cosmic/
cp -r com.system76.CosmicTheme.*.Builder ~/.config/cosmic/

cd kitty 
cp -r *.conf ~/.config/kitty/
cd ../

cd code 
cp settings.json ~/.config/Code/User/

echo "Switched to theme: $next_theme"
echo "Current theme is now set to: $next_theme"