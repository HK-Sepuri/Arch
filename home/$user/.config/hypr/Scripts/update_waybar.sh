#!/bin/bash

## Update Waybar
WAY_COLORS_FILE="/home/hari/.cache/wal/colors-waybar.css"
WAYBAR_FFOLDER="/home/hari/.config/waybar/colors-waybar.css"
# Copy the contents of colours-vscode.json to settings.json
cp "$WAY_COLORS_FILE" "$WAYBAR_FFOLDER"

killall -SIGUSR2 waybar