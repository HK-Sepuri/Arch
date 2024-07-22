#!/bin/bash

# Define thresholds
low_threshold=20
critical_threshold=5

# Get battery information
battery_info=$(upower -i $(upower -e | grep 'battery'))
battery_level=$(echo "$battery_info" | grep -E "percentage" | awk '{print $2}' | tr -d '%')
charging_status=$(echo "$battery_info" | grep -E "state" | awk '{print $2}')

# Check battery status and notify
if [ "$charging_status" == "discharging" ]; then
    if [ "$battery_level" -le "$critical_threshold" ]; then
        notify-send --urgency=critical "Battery Critical!" "Battery level is at ${battery_level}%! Please charge immediately."
        sleep 5
        systemctl suspend
    elif [ "$battery_level" -le "$low_threshold" ]; then
        notify-send --urgency=normal "Battery Low" "Battery level is at ${battery_level}%. Please charge soon."
    fi
elif [ "$charging_status" == "charging" ]; then
    if [ "$battery_level" -eq 90 ]; then
        notify-send --urgency=normal "Battery Fully Charged" "Battery is fully charged at ${battery_level}%."
    fi
fi
