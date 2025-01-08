#!/bin/bash

# Paths
PYWAL_COLORS="$HOME/.cache/wal/colors.json"
FUZZEL_CONFIG="$HOME/.config/fuzzel/fuzzel.ini"

# Check if the Pywal colors file exists
if [[ ! -f "$PYWAL_COLORS" ]]; then
    echo "Pywal colors file not found: $PYWAL_COLORS"
    exit 1
fi

# Check if the Fuzzel config file exists
if [[ ! -f "$FUZZEL_CONFIG" ]]; then
    echo "Fuzzel config file not found: $FUZZEL_CONFIG"
    exit 1
fi

# Convert hex color (e.g., #06080E) to Fuzzel-compatible RGBA (e.g., 06080Eff)
convert_to_rgba() {
    local hex_color="$1"
    echo "${hex_color:1}ff" # Strip the '#' and append 'ff' for no transparency
}

# Read colors from the Pywal cache using jq
TEXT=$(convert_to_rgba "$(jq -r '.colors.color1' "$PYWAL_COLORS")")
PROMPT=$(convert_to_rgba "$(jq -r '.colors.color2' "$PYWAL_COLORS")")
PLACEHOLDER=$(convert_to_rgba "$(jq -r '.colors.color3' "$PYWAL_COLORS")")
INPUT=$(convert_to_rgba "$(jq -r '.colors.color4' "$PYWAL_COLORS")")
MATCH=$(convert_to_rgba "$(jq -r '.colors.color5' "$PYWAL_COLORS")")
SELECTION=$(convert_to_rgba "$(jq -r '.colors.color6' "$PYWAL_COLORS")")
SELECTION_TEXT=$(convert_to_rgba "$(jq -r '.special.background' "$PYWAL_COLORS")")
SELECTION_MATCH=$(convert_to_rgba "$(jq -r '.colors.color8' "$PYWAL_COLORS")")
COUNTER=$(convert_to_rgba "$(jq -r '.colors.color9' "$PYWAL_COLORS")")
BORDER=$(convert_to_rgba "$(jq -r '.colors.color0' "$PYWAL_COLORS")")

# Create the new [colors] section
COLORS_SECTION=$(cat <<EOL
[colors]
background=000000A0
text=$TEXT
prompt=$PROMPT
placeholder=$PLACEHOLDER
input=$INPUT
match=$MATCH
selection=$SELECTION
selection-text=$SELECTION_TEXT
selection-match=$SELECTION_MATCH
counter=$COUNTER
border=$BORDER
EOL
)

# Remove any existing [colors] section
if grep -q "\[colors\]" "$FUZZEL_CONFIG"; then
    awk '!found && /^\[colors\]/ { found = 1; next } found && /^$/ { found = 0; next } !found { print }' "$FUZZEL_CONFIG" > "${FUZZEL_CONFIG}.tmp"
    mv "${FUZZEL_CONFIG}.tmp" "$FUZZEL_CONFIG"
fi

# Append the new [colors] section
echo -e "\n$COLORS_SECTION" >> "$FUZZEL_CONFIG"

# Restart fuzzel (kill existing process and relaunch)
FUZZEL_PID=$(pgrep fuzzel)
if [[ -n "$FUZZEL_PID" ]]; then
    kill "$FUZZEL_PID"
    echo "Fuzzel process killed."
fi
