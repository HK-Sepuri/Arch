#!/usr/bin/env bash

# Function to send notifications
send_notification() {
    local icon=$1
    local message=$2
    local duration=5000  # Notification duration in milliseconds

    hyprctl notify "$icon" "$duration" "$message"
    play_sound  # Call function to play sound
}

# Function to play notification sound
play_sound() {
    paplay /home/hari/.config/hypr/Scripts/notification_sound.wav  # Use paplay or another audio player
}

# Infinite loop to check battery level
while true; do
    # Get battery percentage
    battery_percent=$(cat /sys/class/power_supply/BAT1/capacity)

    # Check battery level and send notifications
    if [[ "$battery_percent" -ge 80 && $(cat /sys/class/power_supply/ACAD/online) -eq 1 ]]; then
        send_notification 2 "Battery is at ${battery_percent}%. Please consider stopping charging."
    elif [[ "$battery_percent" -le 15 ]]; then
        send_notification 3 "Battery is low! Current level: ${battery_percent}%. Please charge."
    elif [[ "$battery_percent" -le 5 ]]; then
        send_notification 4 "Critical battery level! Only ${battery_percent}%. Please charge immediately!"
    fi

    sleep 120  # Check every 2 minutes
done
