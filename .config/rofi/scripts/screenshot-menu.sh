#!/bin/bash

# Screenshot menu with multiple options

OPTIONS=" Full Screen\n Window/Region\n Delayed (3s)\n Copy to Clipboard\n Save to Screenshots"

CHOSEN=$(echo -e "$OPTIONS" | rofi -dmenu -i -p "Screenshot" -config ~/.config/rofi/config.rasi)

SCREENSHOT_DIR="$HOME/Pictures/Screenshots"
mkdir -p "$SCREENSHOT_DIR"

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
FILENAME="screenshot_${TIMESTAMP}.png"

case "$CHOSEN" in
    " Full Screen")
        if command -v grim >/dev/null 2>&1; then
            grim "$SCREENSHOT_DIR/$FILENAME"
            notify-send "Screenshot saved" "$FILENAME"
        elif command -v scrot >/dev/null 2>&1; then
            scrot "$SCREENSHOT_DIR/$FILENAME"
            notify-send "Screenshot saved" "$FILENAME"
        fi
        ;;
    " Window/Region")
        if command -v grim >/dev/null 2>&1 && command -v slurp >/dev/null 2>&1; then
            grim -g "$(slurp)" "$SCREENSHOT_DIR/$FILENAME"
            notify-send "Screenshot saved" "$FILENAME"
        elif command -v scrot >/dev/null 2>&1; then
            scrot -s "$SCREENSHOT_DIR/$FILENAME"
            notify-send "Screenshot saved" "$FILENAME"
        fi
        ;;
    " Delayed (3s)")
        if command -v grim >/dev/null 2>&1; then
            sleep 3 && grim "$SCREENSHOT_DIR/$FILENAME"
            notify-send "Screenshot saved" "$FILENAME"
        elif command -v scrot >/dev/null 2>&1; then
            scrot -d 3 "$SCREENSHOT_DIR/$FILENAME"
            notify-send "Screenshot saved" "$FILENAME"
        fi
        ;;
    " Copy to Clipboard")
        if command -v grim >/dev/null 2>&1 && command -v wl-copy >/dev/null 2>&1; then
            grim -g "$(slurp)" - | wl-copy
            notify-send "Screenshot copied to clipboard"
        elif command -v scrot >/dev/null 2>&1 && command -v xclip >/dev/null 2>&1; then
            scrot -s -e 'xclip -selection clipboard -t image/png $f'
            notify-send "Screenshot copied to clipboard"
        fi
        ;;
    " Save to Screenshots")
        if command -v grim >/dev/null 2>&1; then
            grim -g "$(slurp)" "$SCREENSHOT_DIR/$FILENAME"
            notify-send "Screenshot saved" "$SCREENSHOT_DIR/$FILENAME"
        elif command -v scrot >/dev/null 2>&1; then
            scrot -s "$SCREENSHOT_DIR/$FILENAME"
            notify-send "Screenshot saved" "$SCREENSHOT_DIR/$FILENAME"
        fi
        ;;
esac
