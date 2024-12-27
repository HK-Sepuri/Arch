#!/bin/bash

# Function to play notification sound
play_sound() {
    paplay /home/hari/.config/hypr/Scripts/notification_sound.wav
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
            # Charger plugged in
            notify-send "Charger plugged in!" "The charger is now connected." --icon=dialog-information && play_sound
        else
            # Charger unplugged
            notify-send "Charger unplugged!" "The charger has been disconnected." --icon=dialog-warning && play_sound
        fi
    fi

    # Wait before checking again
    sleep 5
done