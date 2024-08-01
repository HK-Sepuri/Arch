#!/bin/bash

## Update Cava
# Define the source and destination files
WAL_COLOR_FILE="/home/hari/.cache/wal/colors"  # Change this to the actual path of your wal/color file
CAVA_CONFIG_FILE="/home/hari/.config/cava/config"  # Change this to the actual path of your Cava config file

# Read the first 8 lines from the wal/color file
colors=$(head -n 16 "$WAL_COLOR_FILE")

# Extract colors
color1=$(echo "$colors" | sed -n '1p' | tr -d '\n')
color2=$(echo "$colors" | sed -n '3p' | tr -d '\n')
color3=$(echo "$colors" | sed -n '5p' | tr -d '\n')
color4=$(echo "$colors" | sed -n '7p' | tr -d '\n')
color5=$(echo "$colors" | sed -n '9p' | tr -d '\n')
color6=$(echo "$colors" | sed -n '11p' | tr -d '\n')
color7=$(echo "$colors" | sed -n '13p' | tr -d '\n')
color8=$(echo "$colors" | sed -n '15p' | tr -d '\n')

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
