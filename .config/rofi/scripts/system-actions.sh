#!/bin/bash

# System actions menu

ACTIONS="󰒲 Suspend\n󰒸 Hibernate\n󰜉 Reboot\n󰐥 Shutdown\n Lock\n󰍃 Logout\n󰑯 Reload Hyprland\n󱓎 System Info"

CHOSEN=$(echo -e "$ACTIONS" | rofi -dmenu -i -p "System Actions" -config ~/.config/rofi/config.rasi)

case "$CHOSEN" in
    "󰒲 Suspend")
        systemctl suspend
        ;;
    "󰒸 Hibernate")
        systemctl hibernate
        ;;
    "󰜉 Reboot")
        systemctl reboot
        ;;
    "󰐥 Shutdown")
        systemctl poweroff
        ;;
    " Lock")
        if command -v hyprlock >/dev/null 2>&1; then
            hyprlock
        elif command -v swaylock >/dev/null 2>&1; then
            swaylock
        elif command -v i3lock >/dev/null 2>&1; then
            i3lock
        fi
        ;;
    "󰍃 Logout")
        if command -v hyprctl >/dev/null 2>&1; then
            hyprctl dispatch exit
        elif [ "$XDG_CURRENT_DESKTOP" = "Hyprland" ]; then
            pkill Hyprland
        else
            pkill -f "$XDG_SESSION_TYPE"
        fi
        ;;
    "󰑯 Reload Hyprland")
        if command -v hyprctl >/dev/null 2>&1; then
            hyprctl reload
        fi
        ;;
    "󱓎 System Info")
        ~/.config/rofi/scripts/system-info.sh
        ;;
esac