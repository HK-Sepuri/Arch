#!/bin/sh
# "Change keyboard layout in" "~/.config/hypr/hyprland.conf" " " \

yad --width=630 --height=620 \
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
"ESC" "Close this app" "" "=" "Modkey" "(mod Mod4)" \
"+A" "Terminal" "(kitty)" \
"+R" "Application Menu" "(fuzzel)" \
"+W" "" "(librewolf)" \
"+E" "" "(nemo)" \
"+D" "Discord" "(vesktop)" \
"+Q" "Close focused app" "(kill app)" \
"+C" "Exit Hyprland" "(kill hyprland)" \
"+V" "Floating" "(togglefloating)" \
"+F" "Fullscreen" "(Full Screen)" \
"+Y" "Clipboard manager" "(clipse)" \
"Print" "Screenshot" "(hyprshot output)" \
"+Print" "Screenshot window" "(hyprshot window)" \
"Shift+Print" "Screenshot region" "(hyprshot region)" \
"+Arrows" "Move Focus" "(left/right/up/down)" \
"+Shift+Arrows" "Resize Windows" "(Resize windows left/right/up/down)" \
"+(0-9)" "Move To Workspace" "(change to workspace 0-9)" \
"+Shift+(0-9)" "Move Active Window To Workspace" "(move app to workspace 0-9)" \
"+J" "Togglesplit" "Toggles to Vertical/Horizontal" \
"+Tab" "All Windows" "Shows all 9 Windows" \
"+Z" "Zoom" "(Zoom In" \
"+Shift+Z" "Zoom" "Zoom Out" \
"Fn+F9" "Keyboard Backlight" "(turnoff)" \
"Fn+F10" "Keyboard Backlight" "(turnon set 50%)" \
"Fn+F11" "Keyboard Backlight" "(turnon set 100%)" \
"+Mouse+Left" "Move Window" "(drag windows)" \
"" "" "     Window closed in 60 sec."\
