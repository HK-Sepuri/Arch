#!/bin/bash

# Replace '/path/to/your/wallpapers' with the actual path
wallpaper_dir="/home/hari/Pictures/Wallpaper"

# Randomly select a wallpaper from the directory
random_wallpaper=$(ls "$wallpaper_dir" | shuf -n 1)

# Full path to the selected wallpaper
full_wallpaper_path="$wallpaper_dir/$random_wallpaper"

# Get the list of monitors
monitors=$(hyprctl monitors -j | jq -r ".[].name")

# Kill any running instance of hyprpaper
killall hyprpaper

# Create or update the hyprpaper configuration
config_file="$HOME/.config/hypr/hyprpaper.conf"

# Clear existing config if it exists
echo "" > "$config_file"

# Loop through each monitor and set the preload and wallpaper
for monitor in $monitors; do
    echo "preload = $full_wallpaper_path" >> "$config_file"
    echo "wallpaper = $monitor,$full_wallpaper_path" >> "$config_file"
done

# Start hyprpaper to apply the new configuration
hyprpaper &
# Generate color scheme with pywal
wal -i "$full_wallpaper_path"

# Restore the last applied color scheme
wal -R

#Update Waybar
WAY_COLORS_FILE="/home/hari/.cache/wal/colors-waybar.css"
WAYBAR_FFOLDER="/home/hari/.config/waybar/colors-waybar.css"
# Copy the contents of colours-vscode.json to settings.json
cp "$WAY_COLORS_FILE" "$WAYBAR_FFOLDER"

killall -SIGUSR2 waybar

# Apply Discord theme based on Pywal colors
pywal-discord -t theme-dark

# Update Kitty configuration
kitty @ set-colors --all ~/.config/kitty/colors-kitty.conf  # Apply colors 

# Update Code OSS color scheme
WAL_COLORS_FILE="/home/hari/.cache/wal/colors-vscode.json"
CODEOSS_SETTINGS_FILE="/home/hari/.config/Code - OSS/User/settings.json"
# Copy the contents of colours-vscode.json to settings.json
cp "$WAL_COLORS_FILE" "$CODEOSS_SETTINGS_FILE"

# Update Telegram
walogram

#Update Librewolf
pywalfox update


echo "Wallpaper set to $random_wallpaper for all monitors and configuration updated.
