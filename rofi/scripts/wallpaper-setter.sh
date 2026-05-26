#!/bin/bash

# Wallpaper Setter with preview and management
# Supports multiple wallpaper backends

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
WALLPAPER_CACHE="$HOME/.cache/rofi_wallpapers"
mkdir -p "$WALLPAPER_DIR" "$WALLPAPER_CACHE"

# Function to set wallpaper
set_wallpaper() {
    local wallpaper_path="$1"
    
    if [ -f "$wallpaper_path" ]; then
        # Use awww as primary wallpaper setter
        if command -v awww >/dev/null 2>&1; then
            awww img "$wallpaper_path" --transition-type simple --transition-fps 60
        elif command -v hyprctl >/dev/null 2>&1; then
            # Hyprland fallback
            hyprctl misc exec "cp '$wallpaper_path' ~/.config/wallpaper.png"
            hyprctl reload
        elif command -v swaymsg >/dev/null 2>&1; then
            # Sway fallback
            swaymsg output "*" background "$wallpaper_path" fill
        elif command -v feh >/dev/null 2>&1; then
            # feh fallback (X11)
            feh --bg-fill "$wallpaper_path"
        elif command -v nitrogen >/dev/null 2>&1; then
            # nitrogen fallback
            nitrogen --set-scaled "$wallpaper_path"
        else
            rofi -e "No wallpaper setter found (awww, hyprctl, swaymsg, feh, nitrogen)" -config ~/.config/rofi/config.rasi
            return 1
        fi
        
        # Save current wallpaper
        echo "$wallpaper_path" > "$WALLPAPER_CACHE/current_wallpaper"
        notify-send "Wallpaper set" "$(basename "$wallpaper_path")"
        return 0
    fi
}

# Function to get wallpaper preview
get_wallpaper_preview() {
    local wallpaper="$1"
    local basename=$(basename "$wallpaper")
    
    # Create a simple preview with icon
    if [[ "$wallpaper" =~ \.(jpg|jpeg|png|gif|bmp|webp)$ ]]; then
        echo "󰸉  $basename"
    else
        echo "󰈙 $basename"
    fi
}

# Main menu
ACTIONS="󰉋 Browse Wallpapers\n󰎲 Random Wallpaper\n󰑯 Recent Wallpapers\n󰄯 Take Screenshot\n󰖈 Download Wallpaper\n󰒺 Wallpaper Settings"

CHOSEN=$(echo -e "$ACTIONS" | rofi -dmenu -i -p "Wallpaper Setter" -config ~/.config/rofi/config.rasi)

case "$CHOSEN" in
    "󰉋 Browse Wallpapers")
        # Find wallpaper files
        if command -v fd >/dev/null 2>&1; then
            WALLPAPERS=$(fd -e jpg -e jpeg -e png -e gif -e bmp -e webp . "$WALLPAPER_DIR" 2>/dev/null)
        else
            WALLPAPERS=$(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.gif" -o -name "*.bmp" -o -name "*.webp" \) 2>/dev/null)
        fi
        
        if [ -n "$WALLPAPERS" ]; then
            # Create preview list
            WALLPAPER_LIST=""
            while IFS= read -r wallpaper; do
                WALLPAPER_LIST="$WALLPAPER_LIST$(get_wallpaper_preview "$wallpaper")\n"
            done <<< "$WALLPAPERS"
            
            SELECTED=$(echo -e "$WALLPAPER_LIST" | rofi -dmenu -i -p "Select wallpaper" -config ~/.config/rofi/config.rasi)
            
            if [ -n "$SELECTED" ]; then
                # Extract filename and construct full path
                FILENAME=$(echo "$SELECTED" | sed 's/^[^[:space:]]*[[:space:]]*//')
                FULL_PATH="$WALLPAPER_DIR/$FILENAME"
                
                if [ -f "$FULL_PATH" ]; then
                    set_wallpaper "$FULL_PATH"
                fi
            fi
        else
            rofi -e "No wallpapers found in $WALLPAPER_DIR" -config ~/.config/rofi/config.rasi
        fi
        ;;
    "󰎲 Random Wallpaper")
        if command -v fd >/dev/null 2>&1; then
            WALLPAPERS=$(fd -e jpg -e jpeg -e png -e gif -e bmp -e webp . "$WALLPAPER_DIR" 2>/dev/null)
        else
            WALLPAPERS=$(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.gif" -o -name "*.bmp" -o -name "*.webp" \) 2>/dev/null)
        fi
        
        if [ -n "$WALLPAPERS" ]; then
            RANDOM_WALLPAPER=$(echo "$WALLPAPERS" | shuf -n 1)
            set_wallpaper "$RANDOM_WALLPAPER"
        else
            rofi -e "No wallpapers found for random selection" -config ~/.config/rofi/config.rasi
        fi
        ;;
    "󰑯 Recent Wallpapers")
        if [ -f "$WALLPAPER_CACHE/recent_wallpapers" ] && [ -s "$WALLPAPER_CACHE/recent_wallpapers" ]; then
            RECENT_LIST=$(head -10 "$WALLPAPER_CACHE/recent_wallpapers" | while read -r wallpaper; do
                if [ -f "$wallpaper" ]; then
                    get_wallpaper_preview "$wallpaper"
                fi
            done)
            
            SELECTED=$(echo -e "$RECENT_LIST" | rofi -dmenu -i -p "Recent wallpapers" -config ~/.config/rofi/config.rasi)
            
            if [ -n "$SELECTED" ]; then
                FILENAME=$(echo "$SELECTED" | sed 's/^[^[:space:]]*[[:space:]]*//')
                FULL_PATH="$WALLPAPER_DIR/$FILENAME"
                
                if [ -f "$FULL_PATH" ]; then
                    set_wallpaper "$FULL_PATH"
                fi
            fi
        else
            rofi -e "No recent wallpapers found" -config ~/.config/rofi/config.rasi
        fi
        ;;
    "󰄯 Take Screenshot")
        SCREENSHOT_WALLPAPER="$WALLPAPER_DIR/screenshot_$(date +%Y%m%d_%H%M%S).png"
        
        if command -v grim >/dev/null 2>&1; then
            grim "$SCREENSHOT_WALLPAPER"
        elif command -v scrot >/dev/null 2>&1; then
            scrot "$SCREENSHOT_WALLPAPER"
        else
            rofi -e "No screenshot tool found (grim, scrot)" -config ~/.config/rofi/config.rasi
            exit 0
        fi
        
        if [ -f "$SCREENSHOT_WALLPAPER" ]; then
            set_wallpaper "$SCREENSHOT_WALLPAPER"
        fi
        ;;
    "󰖈 Download Wallpaper")
        # Simple wallpaper source selection
        SOURCES="󰖐 Unsplash\n󰏘 DeviantArt\n󰖈 Custom URL"
        SOURCE=$(echo -e "$SOURCES" | rofi -dmenu -i -p "Wallpaper source" -config ~/.config/rofi/config.rasi)
        
        case "$SOURCE" in
            "󰖐 Unsplash")
                # Open Unsplash in browser for manual download
                xdg-open "https://unsplash.com/wallpapers"
                notify-send "Unsplash opened" "Download and set wallpaper manually"
                ;;
            "󰏘 DeviantArt")
                xdg-open "https://www.deviantart.com/search?q=wallpaper"
                notify-send "DeviantArt opened" "Download and set wallpaper manually"
                ;;
            "󰖈 Custom URL")
                URL=$(rofi -dmenu -p "Enter image URL" -config ~/.config/rofi/config.rasi)
                if [ -n "$URL" ]; then
                    FILENAME="download_$(date +%Y%m%d_%H%M%S).${URL##*.}"
                    if command -v wget >/dev/null 2>&1; then
                        wget -O "$WALLPAPER_DIR/$FILENAME" "$URL"
                    elif command -v curl >/dev/null 2>&1; then
                        curl -o "$WALLPAPER_DIR/$FILENAME" "$URL"
                    fi
                    
                    if [ -f "$WALLPAPER_DIR/$FILENAME" ]; then
                        set_wallpaper "$WALLPAPER_DIR/$FILENAME"
                    fi
                fi
                ;;
        esac
        ;;
    "󰒺 Wallpaper Settings")
        SETTINGS="󰉋 Open Wallpaper Folder\n󰆴 Clear Cache\n󰑯 Refresh Wallpapers"
        SETTING=$(echo -e "$SETTINGS" | rofi -dmenu -i -p "Wallpaper settings" -config ~/.config/rofi/config.rasi)
        
        case "$SETTING" in
            "󰉋 Open Wallpaper Folder")
                if command -v xdg-open >/dev/null 2>&1; then
                    xdg-open "$WALLPAPER_DIR"
                fi
                ;;
            "󰆴 Clear Cache")
                rm -f "$WALLPAPER_CACHE"/*
                notify-send "Wallpaper cache cleared"
                ;;
            "󰑯 Refresh Wallpapers")
                rm -f "$WALLPAPER_CACHE"/*
                notify-send "Wallpaper cache refreshed"
                ;;
        esac
        ;;
esac
