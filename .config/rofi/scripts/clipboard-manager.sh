#!/bin/bash

# Clipboard Manager with history
# Requires wl-clipboard for Wayland or xclip for X11

CLIPBOARD_FILE="$HOME/.cache/rofi_clipboard_history"
CLIPBOARD_LIMIT=50

# Create cache directory
mkdir -p "$(dirname "$CLIPBOARD_FILE")"

# Function to add to clipboard history
add_to_history() {
    local content="$1"
    # Remove duplicates and add to top
    grep -vxF -f <(echo "$content") "$CLIPBOARD_FILE" 2>/dev/null | head -n $((CLIPBOARD_LIMIT - 1)) > "${CLIPBOARD_FILE}.tmp"
    echo "$content" > "${CLIPBOARD_FILE}.tmp2"
    cat "${CLIPBOARD_FILE}.tmp2" "${CLIPBOARD_FILE}.tmp" > "$CLIPBOARD_FILE"
    rm -f "${CLIPBOARD_FILE}.tmp" "${CLIPBOARD_FILE}.tmp2"
}

# Function to get current clipboard content
get_current_clipboard() {
    if command -v wl-paste >/dev/null 2>&1; then
        wl-paste
    elif command -v xclip >/dev/null 2>&1; then
        xclip -selection clipboard -o
    fi
}

# Function to copy to clipboard
copy_to_clipboard() {
    local content="$1"
    if command -v wl-copy >/dev/null 2>&1; then
        echo "$content" | wl-copy
    elif command -v xclip >/dev/null 2>&1; then
        echo "$content" | xclip -selection clipboard
    fi
}

# Main menu
ACTIONS="󰅪 View History\n󰎚 Add Current\n󰆴 Clear History\n󰑯 Monitor Clipboard"

CHOSEN=$(echo -e "$ACTIONS" | rofi -dmenu -i -p "Clipboard Manager" -config ~/.config/rofi/config.rasi)

case "$CHOSEN" in
    "󰅪 View History")
        if [ -f "$CLIPBOARD_FILE" ] && [ -s "$CLIPBOARD_FILE" ]; then
            # Display history with line numbers
            HISTORY=$(nl -w 2 -s ". " "$CLIPBOARD_FILE" | sed 's/^/󰈙 /')
            SELECTED=$(echo -e "$HISTORY" | rofi -dmenu -i -p "Select to copy" -config ~/.config/rofi/config.rasi)
            
            if [ -n "$SELECTED" ]; then
                # Extract the content (remove line number and icon)
                CONTENT=$(echo "$SELECTED" | sed 's/^[^[:space:]]*[[:space:]]*📄[[:space:]]*//' | sed 's/^[0-9]*[.[:space:]]*//')
                copy_to_clipboard "$CONTENT"
                notify-send "Copied to clipboard" "Length: ${#CONTENT} chars"
            fi
        else
            rofi -e "No clipboard history found" -config ~/.config/rofi/config.rasi
        fi
        ;;
    "󰎚 Add Current")
        CURRENT=$(get_current_clipboard)
        if [ -n "$CURRENT" ]; then
            add_to_history "$CURRENT"
            notify-send "Added to clipboard history" "Length: ${#CURRENT} chars"
        else
            rofi -e "Clipboard is empty" -config ~/.config/rofi/config.rasi
        fi
        ;;
    "󰆴 Clear History")
        if rofi -dmenu -i -p "Clear clipboard history? (y/N)" -config ~/.config/rofi/config.rasi | grep -qi "^y"; then
            rm -f "$CLIPBOARD_FILE"
            notify-send "Clipboard history cleared"
        fi
        ;;
    "󰑯 Monitor Clipboard")
        rofi -e "Clipboard monitoring requires background service. Add to startup: watch -n 1 'wl-paste >> $CLIPBOARD_FILE'" -config ~/.config/rofi/config.rasi
        ;;
esac
