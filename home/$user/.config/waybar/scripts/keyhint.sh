#!/bin/sh
# "Change keyboard layout in" "~/.config/hypr/hyprland.conf" " " \

yad --width=530 --height=620 \
--center \
--fixed \
--title="Arch Hyprland Keybindings" \
--no-buttons \
--list \
--column=Key: \
--column=Description: \
--column=Command: \
--timeout=60 \
--timeout-indicator=right \
"ESC" "close this app" "" "=" "modkey" "(mod Mod4)" \
"+A" "Terminal" "(kitty)" \
"+R" "Application Menu" "(rofi-wayland)" \
"+W" "" "(librewolf)" \
"+E" "" "(thunar)" \
"+D" "Discord" "(discord)" \
"+Q" "close focused app" "(kill app)" \
"+C" "Exit Hyprland" "(kill hyprland)" \
"+V" "Floating" "(togglefloating)" \
"+Y" "clipboard manager" "(clipse)" \
"Print" "screenshot" "(hyprshot output)" \
"+Print" "screenshot window" "(hyprshot window)" \
"+Shift+Print" "screenshot region" "(hyprshot region)" \
"+Left" "Move Focus" "(left)" \
"+Right" "Move Focus" "(right)" \
"+Up" "Move Focus" "(up)" \
"+Down" "Move Focus" "(down)" \
"+(0-9)" "Move To Workspace" "(change to workspace 0-9)" \
"+Shift+(0-9)" "Move Active Window To Workspace" "(move app to workspace 0-9)" \
"+J" "Togglesplit" "Toggles to Vertical/Horizontal" \
"+\`" "All Windows" "Shows all 9 Windows" \
"Fn+F9" "Keyboard Backlight" "(turnoff)" \
"Fn+F10" "Keyboard Backlight" "(turnon set 50%)" \
"Fn+F11" "Keyboard Backlight" "(turnon set 100%)" \
"+Mouse+Left" "Move Window" "(drag windows)" \
"" "" "     Window closed in 60 sec."\
