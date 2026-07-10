#!/bin/bash

# Raycast-like launcher for Rofi
# Main script that provides different modes

MODES="󱗼 Applications\n Search Files\n Screenshots\n System Actions\n Media Control\n Quick Settings\n󰅪 Clipboard\n Calculator\n󰍉 Web Search\n󰏘 Color Picker\n󰸉 Wallpaper\n󰐦 Process Killer\n󰋚 Packages\n󰏘 Theme Switcher\n󰂲 Bluetooth"

CHOSEN=$(echo -e "$MODES" | rofi -dmenu -i -p "A7R-M" -config ~/.config/rofi/config.rasi)

case "$CHOSEN" in
    "󱗼 Applications")
        rofi -show drun -config ~/.config/rofi/config.rasi
        ;;
    " Search Files")
        ~/.config/rofi/scripts/file-search.sh
        ;;
    " Screenshots")
        ~/.config/rofi/scripts/screenshot-menu.sh
        ;;
    " System Actions")
        ~/.config/rofi/scripts/system-actions.sh
        ;;
    " Media Control")
        ~/.config/rofi/scripts/media-control.sh
        ;;
    " Quick Settings")
        ~/.config/rofi/scripts/quick-settings.sh
        ;;
    "󰅪 Clipboard")
        ~/.config/rofi/scripts/clipboard-manager.sh
        ;;
    " Calculator")
        ~/.config/rofi/scripts/calculator.sh
        ;;
    "󰍉 Web Search")
        ~/.config/rofi/scripts/web-search.sh
        ;;
    "󰏘 Color Picker")
        ~/.config/rofi/scripts/color-picker.sh
        ;;
    "󰸉 Wallpaper")
        ~/.config/rofi/scripts/wallpaper-setter.sh
        ;;
    "󰐦 Process Killer")
        ~/.config/rofi/scripts/process-killer.sh
        ;;
    "󰋚 Packages")
        ~/.config/rofi/scripts/package-manager.sh
        ;;
    "󰏘 Theme Switcher")
        ~/.config/rofi/scripts/theme-switcher.sh
        ;;
    "󰂲 Bluetooth")
        ~/.config/rofi/scripts/bluetooth-control.sh
        ;;
esac
