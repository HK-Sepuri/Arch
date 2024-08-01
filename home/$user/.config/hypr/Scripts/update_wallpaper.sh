#!/bin/bash

wallpaper_dir="/home/hari/Pictures/Wallpaper"
config_file="$HOME/.config/hypr/hyprpaper.conf"
index_file="$HOME/.config/hypr/wallpaper_index"

# Create the index file if it does not exist
if [ ! -f "$index_file" ]; then
    echo 0 > "$index_file"
fi

# Get the list of wallpapers and the current index
wallpapers=("$wallpaper_dir"/*)
current_index=$(cat "$index_file")

# Select the next wallpaper
next_index=$(( (current_index + 1) % ${#wallpapers[@]} ))
selected_wallpaper="${wallpapers[$next_index]}"

# Update the index file
echo "$next_index" > "$index_file"

# Get the list of monitors
monitors=$(hyprctl monitors -j | jq -r ".[].name")

# Kill any running instance of hyprpaper
killall hyprpaper

# Clear existing config if it exists
echo "" > "$config_file"

# Loop through each monitor and set the preload and wallpaper
for monitor in $monitors; do
    echo "preload = $selected_wallpaper" >> "$config_file"
    echo "wallpaper = $monitor,$selected_wallpaper" >> "$config_file"
done

# Start hyprpaper to apply the new configuration
hyprpaper &
# Generate color scheme with pywal
wal -i "$selected_wallpaper"

# Restore the last applied color scheme
wal -R

echo "Wallpaper set to $random_wallpaper for all monitors and configuration updated.