#!/bin/bash

# Media control menu

ACTIONS="󰐎 Play/Pause\n󰒮 Previous\n󰒭 Next\n󰓛 Stop\n󰝝 Volume Up\n󰝞 Volume Down\n󰝟 Mute/Unmute"

CHOSEN=$(echo -e "$ACTIONS" | rofi -dmenu -i -p "Media Control" -config ~/.config/rofi/config.rasi)

case "$CHOSEN" in
    "󰐎 Play/Pause")
        playerctl play-pause 2>/dev/null || mpc toggle 2>/dev/null
        ;;
    "󰒮 Previous")
        playerctl previous 2>/dev/null || mpc prev 2>/dev/null
        ;;
    "󰒭 Next")
        playerctl next 2>/dev/null || mpc next 2>/dev/null
        ;;
    "󰓛 Stop")
        playerctl stop 2>/dev/null || mpc stop 2>/dev/null
        ;;
    "󰝝 Volume Up")
        if command -v wpctl >/dev/null 2>&1; then
            wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
        elif command -v pactl >/dev/null 2>&1; then
            pactl set-sink-volume @DEFAULT_SINK@ +5%
        elif command -v amixer >/dev/null 2>&1; then
            amixer set Master 5%+
        fi
        ;;
    "󰝞 Volume Down")
        if command -v wpctl >/dev/null 2>&1; then
            wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
        elif command -v pactl >/dev/null 2>&1; then
            pactl set-sink-volume @DEFAULT_SINK@ -5%
        elif command -v amixer >/dev/null 2>&1; then
            amixer set Master 5%-
        fi
        ;;
    "󰝟 Mute/Unmute")
        if command -v wpctl >/dev/null 2>&1; then
            wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        elif command -v pactl >/dev/null 2>&1; then
            pactl set-sink-mute @DEFAULT_SINK@ toggle
        elif command -v amixer >/dev/null 2>&1; then
            amixer set Master toggle
        fi
        ;;
esac