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

## Update Waybar
WAY_COLORS_FILE="/home/hari/.cache/wal/colors-waybar.css"
WAYBAR_FFOLDER="/home/hari/.config/waybar/colors-waybar.css"
# Copy the contents of colours-vscode.json to settings.json
cp "$WAY_COLORS_FILE" "$WAYBAR_FFOLDER"

killall -SIGUSR2 waybar

## Update Kitty configuration
kitty @ set-colors --all ~/.config/kitty/colors-kitty.conf  # Apply colors 

## Update Code OSS color scheme
WAL_COLORS_FILE="/home/hari/.cache/wal/colors-vscode.json"
CODEOSS_SETTINGS_FILE="/home/hari/.config/Code - OSS/User/settings.json"
# Copy the contents of colours-vscode.json to settings.json
cp "$WAL_COLORS_FILE" "$CODEOSS_SETTINGS_FILE"

## Update Telegram
walogram

## Update Librewolf
pywalfox update

## Update Swaync
swaync-client --reload-config
swaync-client -rs

## Update Cava
# Define the source and destination files
WAL_COLOR_FILE="/home/hari/.cache/wal/colors"  # Change this to the actual path of your wal/color file
CAVA_CONFIG_FILE="/home/hari/.config/cava/config"  # Change this to the actual path of your Cava config file

# Read the first 8 lines from the wal/color file
colors=$(head -n 8 "$WAL_COLOR_FILE")

# Extract colors
color1=$(echo "$colors" | sed -n '1p' | tr -d '\n')
color2=$(echo "$colors" | sed -n '2p' | tr -d '\n')
color3=$(echo "$colors" | sed -n '3p' | tr -d '\n')
color4=$(echo "$colors" | sed -n '4p' | tr -d '\n')
color5=$(echo "$colors" | sed -n '5p' | tr -d '\n')
color6=$(echo "$colors" | sed -n '6p' | tr -d '\n')
color7=$(echo "$colors" | sed -n '7p' | tr -d '\n')
color8=$(echo "$colors" | sed -n '8p' | tr -d '\n')

# Create the new gradient configuration without extra #
new_gradient=$(cat <<EOF
gradient = 1
gradient_count = 8
gradient_color_1 = '$color1'
gradient_color_2 = '$color2'
gradient_color_3 = '$color3'
gradient_color_4 = '$color4'
gradient_color_5 = '$color5'
gradient_color_6 = '$color6'
gradient_color_7 = '$color7'
gradient_color_8 = '$color8'
EOF
)

# Use a temporary file for the new gradient configuration
temp_file=$(mktemp)
echo "$new_gradient" > "$temp_file"

# Replace the existing gradient section in the Cava config file
awk -v new_gradient="$new_gradient" '
    BEGIN { in_gradient_section = 0 }
    /^gradient = 1$/ { 
        in_gradient_section = 1 
        print new_gradient
        next
    }
    in_gradient_section && /^gradient_color_8 = .*/ { 
        in_gradient_section = 0 
        next
    }
    !in_gradient_section { print }
' "$CAVA_CONFIG_FILE" > "$CAVA_CONFIG_FILE.tmp"

# Move the temporary file back to the original config file
mv "$CAVA_CONFIG_FILE.tmp" "$CAVA_CONFIG_FILE"

# Remove the temporary file
rm "$temp_file"

echo "Wallpaper set to $random_wallpaper for all monitors and configuration updated.