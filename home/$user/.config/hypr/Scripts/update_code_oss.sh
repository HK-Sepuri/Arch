#!/bin/bash

## Update Code OSS color scheme
WAL_COLORS_FILE="/home/hari/.cache/wal/colors-vscode.json"
CODEOSS_SETTINGS_FILE="/home/hari/.config/Code/User/settings.json"
# Copy the contents of colours-vscode.json to settings.json
cp "$WAL_COLORS_FILE" "$CODEOSS_SETTINGS_FILE"
