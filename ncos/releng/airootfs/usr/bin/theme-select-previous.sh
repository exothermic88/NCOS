#!/bin/bash

# Define the base themes directory
themes_base="$HOME/.config/themes/"
# List of theme directories
themes=("purple" "red" "nord")

# Temporary file to store the current theme
theme_file="$HOME/.current_theme"

# Check if the theme file exists; if not, initialize it with "nord"
if [ ! -f "$theme_file" ]; then
    echo "nord" > "$theme_file"
fi

# Read the current theme from the file
current_theme_name=$(cat "$theme_file")
echo "Current theme before change: $current_theme_name"

# Backup current config to current theme directory
current_theme_dir="$themes_base/$current_theme_name"
echo "Backing up current configuration to $current_theme_dir..."

# Create directories if they don't exist
mkdir -p "$current_theme_dir"
mkdir -p "$current_theme_dir/kitty"
mkdir -p "$current_theme_dir/code"

# Backup Cosmic files
cp -r ~/.config/cosmic/com.system76.Cosmic* "$current_theme_dir/cosmic/" 2>/dev/null

# Backup Kitty config
cp ~/.config/kitty/*.conf "$current_theme_dir/kitty/" 2>/dev/null

# Backup VSCode settings
cp ~/.config/Code/User/settings.json "$current_theme_dir/code/" 2>/dev/null

echo "Backup completed."

# Find the index of the current theme
current_index=-1
for i in "${!themes[@]}"; do
    if [[ "${themes[$i]}" == "$current_theme_name" ]]; then
        current_index=$i
        break
    fi
done

echo "Current index: $current_index"

# Determine the next theme index
if [ $current_index -eq -1 ]; then
    next_index=0
else
    next_index=$(( (current_index + 1) % ${#themes[@]} ))
fi

echo "Next index: $next_index"

# Change to the next theme directory
next_theme="${themes[$next_index]}"
cd "$themes_base/$next_theme" || { echo "Theme directory not found!"; exit 1; }

# Update the theme file with the new current theme
echo "$next_theme" > "$theme_file"

# Copy the relevant files to the config directory
cp -r cosmic ~/.config/

cd kitty 
cp -r *.conf ~/.config/kitty/
cd ../

cd code 
cp settings.json ~/.config/Code/User/

echo "Switched to theme: $next_theme"
echo "Current theme is now set to: $next_theme"