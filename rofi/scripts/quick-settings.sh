#!/bin/bash

# Quick settings menu

SETTINGS="󰖔 Dark Mode\n󰖙 Light Mode\n󰍹 Display Mode\n󰁹 Power Profile\n󰖈 Network Manager\n󱓎 Performance Monitor"

CHOSEN=$(echo -e "$SETTINGS" | rofi -dmenu -i -p "Quick Settings" -config ~/.config/rofi/config.rasi)

case "$CHOSEN" in
    "󰖔 Dark Mode")
        # Set dark mode for GTK and Qt
        gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"
        export QT_QPA_PLATFORMTHEME=gtk2
        notify-send "Dark mode enabled"
        ;;
    "󰖙 Light Mode")
        # Set light mode for GTK and Qt
        gsettings set org.gnome.desktop.interface gtk-theme "Adwaita"
        export QT_QPA_PLATFORMTHEME=gtk2
        notify-send "Light mode enabled"
        ;;
    "󰍹 Display Mode")
        ~/.config/rofi/scripts/display-mode.sh
        ;;
    "󰁹 Power Profile")
        if command -v powerprofilesctl >/dev/null 2>&1; then
            PROFILES=$(powerprofilesctl list | grep -E "^\s*\*" | awk '{print $2}')
            CHOSEN_PROFILE=$(echo -e "power-saver\nbalanced\nperformance" | rofi -dmenu -i -p "Power Profile" -config ~/.config/rofi/config.rasi)
            if [ -n "$CHOSEN_PROFILE" ]; then
                powerprofilesctl set "$CHOSEN_PROFILE"
                notify-send "Power profile set to $CHOSEN_PROFILE"
            fi
        fi
        ;;
    "󰖈 Network Manager")
        if command -v nmcli >/dev/null 2>&1; then
            ~/.config/rofi/scripts/network-manager.sh
        fi
        ;;
    "󱓎 Performance Monitor")
        if command -v btop >/dev/null 2>&1; then
            kitty --class btop btop
        elif command -v htop >/dev/null 2>&1; then
            kitty --class htop htop
        else
            rofi -e "Install btop or htop for performance monitoring" -config ~/.config/rofi/config.rasi
        fi
        ;;
esac