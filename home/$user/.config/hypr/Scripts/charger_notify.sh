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

# Get the initial charging status
charging_status=$(cat /sys/class/power_supply/ACAD/online)

# Infinite loop to check charging status
while true; do
    # Get the current charging status
    new_charging_status=$(cat /sys/class/power_supply/ACAD/online)

    # Check if the charging status has changed
    if [[ "$new_charging_status" != "$charging_status" ]]; then
        # Update the charging status
        charging_status="$new_charging_status"

        # Send notification based on charging status
        if [[ "$charging_status" == "1" ]]; then
            send_notification 1 "Charger plugged in!"
        else
            send_notification 3 "Charger unplugged!"
        fi
    fi

    sleep 5  # Check every 5 seconds
done
