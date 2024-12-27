#!/bin/bash

# Function to play notification sound
play_sound() {
    paplay /home/hari/.config/hypr/Scripts/notification_sound.wav  # Use paplay or another audio player
}

# Get the initial charging status
charging_status=$(cat /sys/class/power_supply/ACAD/online)

# Infinite loop to check battery level
while true; do
    # Get battery percentage
    battery_percent=$(cat /sys/class/power_supply/BAT1/capacity)
    
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

    # Send battery notifications only if charger is not plugged in
    if [[ "$charging_status" == "0" ]]; then
        # Check battery level and send notifications with icons and urgency
        if [[ "$battery_percent" -ge 80 ]]; then
            notify-send -i battery-full "Battery Warning" "Battery is at ${battery_percent}%. Please consider stopping charging." -u normal && play_sound
        elif [[ "$battery_percent" -le 15 ]]; then
            notify-send -i battery-low "Battery Low" "Battery is low! Current level: ${battery_percent}%. Please charge." -u critical && play_sound
        elif [[ "$battery_percent" -le 5 ]]; then
            notify-send -i battery-caution "Critical Battery" "Critical battery level! Only ${battery_percent}%. Please charge immediately!" -u critical && play_sound
        fi
    fi

    # Wait before checking again
    sleep 120  # Check every 2 minutes
done

    sleep 120  # Check every 2 minutes
done
