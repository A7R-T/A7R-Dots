#!/bin/bash

# Window switcher for Hyprland
# Requires jq for JSON parsing

if command -v jq >/dev/null 2>&1 && command -v hyprctl >/dev/null 2>&1; then
    # Get active workspace
    ACTIVE_WORKSPACE=$(hyprctl activeworkspace -j | jq -r '.id')
    
    # Get windows on active workspace
    WINDOWS=$(hyprctl clients -j | jq -r --arg ws "$ACTIVE_WORKSPACE" \
        'map(select(.workspace.id == ($ws | tonumber))) | 
         sort_by(.at[1]) | 
         map("\(.class): \(.title) (\(.address))") | 
         .[]')
    
    if [ -n "$WINDOWS" ]; then
        CHOSEN=$(echo -e "$WINDOWS" | rofi -dmenu -i -p "Switch Window" -config ~/.config/rofi/config.rasi)
        
        if [ -n "$CHOSEN" ]; then
            # Extract window address
            ADDRESS=$(echo "$CHOSEN" | sed 's/.*(\(0x.*\))/\1/')
            hyprctl dispatch focuswindow address:"$ADDRESS"
        fi
    fi
else
    # Fallback using wmctrl if available
    if command -v wmctrl >/dev/null 2>&1; then
        WINDOWS=$(wmctrl -l | awk '{$3=$4=""; print $0}' | sed 's/^[ ]*//')
        CHOSEN=$(echo -e "$WINDOWS" | rofi -dmenu -i -p "Switch Window" -config ~/.config/rofi/config.rasi)
        
        if [ -n "$CHOSEN" ]; then
            WINDOW_ID=$(echo "$CHOSEN" | awk '{print $1}')
            wmctrl -i -a "$WINDOW_ID"
        fi
    else
        rofi -e "Window switching requires Hyprland with jq or wmctrl" -config ~/.config/rofi/config.rasi
    fi
fi