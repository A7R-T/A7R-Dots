#!/bin/bash

# Color Picker with screen color selection
# Requires grim and slurp for Wayland, or gnome-screenshot for X11

COLOR_HISTORY="$HOME/.cache/rofi_color_history"
mkdir -p "$(dirname "$COLOR_HISTORY")"

# Function to add color to history
add_color_to_history() {
    local color="$1"
    # Remove duplicates and add to top
    grep -vxF -f <(echo "$color") "$COLOR_HISTORY" 2>/dev/null | head -n 19 > "${COLOR_HISTORY}.tmp"
    echo "$color" > "${COLOR_HISTORY}.tmp2"
    cat "${COLOR_HISTORY}.tmp2" "${COLOR_HISTORY}.tmp" > "$COLOR_HISTORY"
    rm -f "${COLOR_HISTORY}.tmp" "${COLOR_HISTORY}.tmp2"
}

# Function to convert hex to RGB
hex_to_rgb() {
    local hex="$1"
    hex=${hex#'#'}
    r=$((16#${hex:0:2}))
    g=$((16#${hex:2:2}))
    b=$((16#${hex:4:2}))
    echo "$r,$g,$b"
}

# Function to convert RGB to hex
rgb_to_hex() {
    local rgb="$1"
    IFS=',' read -r r g b <<< "$rgb"
    printf "#%02x%02x%02x" "$r" "$g" "$b"
}

# Main menu
ACTIONS="󰏘 Pick from Screen\n󰎚 Enter Color Code\n󰉋 Color History\n󰎲 Random Color"

CHOSEN=$(echo -e "$ACTIONS" | rofi -dmenu -i -p "Color Picker" -config ~/.config/rofi/config.rasi)

case "$CHOSEN" in
    "󰏘 Pick from Screen")
        if command -v hyprpicker >/dev/null 2>&1; then
            # Use hyprpicker for Hyprland
            COLOR=$(hyprpicker -a -r)
        elif command -v grim >/dev/null 2>&1 && command -v slurp >/dev/null 2>&1; then
            # Wayland fallback
            COLOR=$(grim -g "$(slurp -p)" - | convert - -format '%[pixel:p{0,0}]' txt:- | tail -1 | cut -d' ' -f4)
        elif command -v gnome-screenshot >/dev/null 2>&1; then
            # X11 fallback (requires imagemagick)
            rofi -e "Take a screenshot first, then this feature will work" -config ~/.config/rofi/config.rasi
            exit 0
        else
            rofi -e "Requires hyprpicker, grim and slurp for Wayland" -config ~/.config/rofi/config.rasi
            exit 0
        fi
        
        if [ -n "$COLOR" ]; then
            # Convert to hex if needed
            if [[ "$COLOR" =~ ^[0-9,]+$ ]]; then
                COLOR=$(rgb_to_hex "$COLOR")
            fi
            
            add_color_to_history "$COLOR"
            
            # Show color with options
            OPTIONS="󰅪 Copy Hex\n󰅪 Copy RGB\n󰏘 View Color\n󰑯 Pick Another"
            ACTION=$(echo -e "$OPTIONS" | rofi -dmenu -i -p "Color: $COLOR" -config ~/.config/rofi/config.rasi)
            
            case "$ACTION" in
                "󰅪 Copy Hex")
                    if command -v wl-copy >/dev/null 2>&1; then
                        echo "$COLOR" | wl-copy
                    elif command -v xclip >/dev/null 2>&1; then
                        echo "$COLOR" | xclip -selection clipboard
                    fi
                    notify-send "Color copied" "$COLOR"
                    ;;
                "󰅪 Copy RGB")
                    RGB=$(hex_to_rgb "$COLOR")
                    if command -v wl-copy >/dev/null 2>&1; then
                        echo "$RGB" | wl-copy
                    elif command -v xclip >/dev/null 2>&1; then
                        echo "$RGB" | xclip -selection clipboard
                    fi
                    notify-send "Color copied" "RGB: $RGB"
                    ;;
                "󰏘 View Color")
                    # Create a temporary color preview
                    PREVIEW_FILE="/tmp/color_preview.html"
                    cat > "$PREVIEW_FILE" << EOF
<!DOCTYPE html>
<html>
<head><title>Color Preview</title></head>
<body style="background-color: $COLOR; margin: 0; padding: 20px; font-family: monospace;">
    <div style="background: rgba(0,0,0,0.7); color: white; padding: 20px; border-radius: 10px; max-width: 300px;">
        <h2>$COLOR</h2>
        <p>RGB: $(hex_to_rgb "$COLOR")</p>
    </div>
</body>
</html>
EOF
                    xdg-open "$PREVIEW_FILE"
                    ;;
                "󰑯 Pick Another")
                    ~/.config/rofi/scripts/color-picker.sh
                    ;;
            esac
        fi
        ;;
    "󰎚 Enter Color Code")
        INPUT_COLOR=$(rofi -dmenu -p "Enter color (hex or RGB)" -config ~/.config/rofi/config.rasi)
        if [ -n "$INPUT_COLOR" ]; then
            # Validate and normalize color
            if [[ "$INPUT_COLOR" =~ ^#[0-9a-fA-F]{6}$ ]]; then
                COLOR="$INPUT_COLOR"
            elif [[ "$INPUT_COLOR" =~ ^[0-9]{1,3},[0-9]{1,3},[0-9]{1,3}$ ]]; then
                COLOR=$(rgb_to_hex "$INPUT_COLOR")
            else
                rofi -e "Invalid color format" -config ~/.config/rofi/config.rasi
                exit 0
            fi
            
            add_color_to_history "$COLOR"
            
            if command -v wl-copy >/dev/null 2>&1; then
                echo "$COLOR" | wl-copy
            elif command -v xclip >/dev/null 2>&1; then
                echo "$COLOR" | xclip -selection clipboard
            fi
            notify-send "Color copied" "$COLOR"
        fi
        ;;
    "󰉋 Color History")
        if [ -f "$COLOR_HISTORY" ] && [ -s "$COLOR_HISTORY" ]; then
            HISTORY_DISPLAY=$(nl -w 2 -s ". " "$COLOR_HISTORY" | sed 's/^/󰏘 /')
            SELECTED=$(echo -e "$HISTORY_DISPLAY" | rofi -dmenu -i -p "Select color" -config ~/.config/rofi/config.rasi)
            
            if [ -n "$SELECTED" ]; then
                COLOR=$(echo "$SELECTED" | sed 's/^[^[:space:]]*[[:space:]]*🎨[[:space:]]*//' | sed 's/^[0-9]*[.[:space:]]*//')
                
                if command -v wl-copy >/dev/null 2>&1; then
                    echo "$COLOR" | wl-copy
                elif command -v xclip >/dev/null 2>&1; then
                    echo "$COLOR" | xclip -selection clipboard
                fi
                notify-send "Color copied" "$COLOR"
            fi
        else
            rofi -e "No color history found" -config ~/.config/rofi/config.rasi
        fi
        ;;
    "󰎲 Random Color")
        RANDOM_COLOR=$(printf "#%02x%02x%02x" $((RANDOM%256)) $((RANDOM%256)) $((RANDOM%256)))
        add_color_to_history "$RANDOM_COLOR"
        
        if command -v wl-copy >/dev/null 2>&1; then
            echo "$RANDOM_COLOR" | wl-copy
        elif command -v xclip >/dev/null 2>&1; then
            echo "$RANDOM_COLOR" | xclip -selection clipboard
        fi
        notify-send "Random color generated" "$RANDOM_COLOR"
        ;;
esac