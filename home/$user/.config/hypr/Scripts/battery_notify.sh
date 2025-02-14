#!/bin/bash

# Function to play notification sound
play_sound() {
    paplay /home/hari/.config/hypr/Scripts/notification_sound.wav
}

# Infinite loop to check battery level
while true; do
    # Get battery percentage
    battery_percent=$(cat /sys/class/power_supply/BAT1/capacity)
    new_charging_status=$(cat /sys/class/power_supply/ACAD/online)

    # Check battery level and send notifications with icons and urgency
    if [[ "$battery_percent" -ge 83 && "$new_charging_status" -eq 1 ]]; then
        notify-send -i battery-full "Battery Warning" "Battery is at ${battery_percent}%. Please consider stopping charging." -u normal && play_sound
    elif [[ "$battery_percent" -le 15&& "$new_charging_status" -eq 0 ]]; then
        notify-send -i battery-low "Battery Low" "Battery is low! Current level: ${battery_percent}%. Please charge." -u critical && play_sound
    elif [[ "$battery_percent" -le 5 && "$new_charging_status" -eq 0 ]]; then
        notify-send -i battery-caution "Critical Battery" "Critical battery level! Only ${battery_percent}%. Please charge immediately!" -u critical && play_sound
    fi

    sleep 120  # Check every 2 minutes
done
