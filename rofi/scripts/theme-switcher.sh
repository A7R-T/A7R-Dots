#!/bin/bash

# Theme Switcher for A7R Desktop Environment
# Switches themes across: kitty, neovim, waybar, hyprland, doom-emacs, rofi, thorium

THEME_DIR="$HOME/.config/rofi/themes"
THEMES="󰏘 A7R-Theme\n󰼶 Nord\n󰕱 Everforest"

CHOSEN=$(echo -e "$THEMES" | rofi -dmenu -i -p "Select Theme" -config ~/.config/rofi/config.rasi)

apply_theme() {
    local theme_name="$1"
    
    case "$theme_name" in
        "󰏘 A7R-Theme")
            apply_a7r_theme
            ;;
        "󰼶 Nord")
            apply_nord_theme
            ;;
        "󰕱 Everforest")
            apply_everforest_theme
            ;;
    esac
    
    # Reload applications
    reload_applications
}

apply_a7r_theme() {
    # Copy A7R theme configs - DO NOT TOUCH DOOM EMACS
    cp "$THEME_DIR/a7r/kitty.conf" "$HOME/.config/kitty/kitty.conf"
    cp "$THEME_DIR/a7r/config.rasi" "$HOME/.config/rofi/config.rasi"
    cp "$THEME_DIR/a7r/colors.lua" "$HOME/.config/nvim/lua/config/colors.lua"
    cp "$THEME_DIR/a7r/style.css" "$HOME/.config/waybar/style.css"
    cp "$THEME_DIR/a7r/hyprland.conf" "$HOME/.config/hypr/hyprland.conf"
}

apply_nord_theme() {
    # Copy Nord theme configs - DO NOT TOUCH DOOM EMACS
    cp "$THEME_DIR/nord/kitty.conf" "$HOME/.config/kitty/kitty.conf"
    cp "$THEME_DIR/nord/config.rasi" "$HOME/.config/rofi/config.rasi"
    cp "$THEME_DIR/nord/colors.lua" "$HOME/.config/nvim/lua/config/colors.lua"
    cp "$THEME_DIR/nord/style.css" "$HOME/.config/waybar/style.css"
    cp "$THEME_DIR/nord/hyprland.conf" "$HOME/.config/hypr/hyprland.conf"
}

apply_everforest_theme() {
    # Copy Everforest theme configs - DO NOT TOUCH DOOM EMACS
    cp "$THEME_DIR/everforest/kitty.conf" "$HOME/.config/kitty/kitty.conf"
    cp "$THEME_DIR/everforest/config.rasi" "$HOME/.config/rofi/config.rasi"
    cp "$THEME_DIR/everforest/colors.lua" "$HOME/.config/nvim/lua/config/colors.lua"
    cp "$THEME_DIR/everforest/style.css" "$HOME/.config/waybar/style.css"
    cp "$THEME_DIR/everforest/hyprland.conf" "$HOME/.config/hypr/hyprland.conf"
}

reload_applications() {
    # Reload waybar
    pkill waybar && waybar &
    
    # Reload hyprland config
    hyprctl reload
    
    # Handle neovim theme reload
    if pgrep -x "nvim" > /dev/null; then
        # Create a notification with instructions
        notify-send "Neovim Theme Update" "
Theme has been applied! 
To update Neovim:
1. Restart Neovim instances, OR
2. Run ':lua require(\"config.colors\")' in any Neovim session" -t 4000
        
        # Create theme trigger file for auto-reload (if theme-watcher is loaded)
        echo "Theme updated at $(date)" > "$HOME/.config/rofi/current-theme"
    fi
    
    # Notify user - Doom Emacs is NOT affected
    notify-send "✅ Theme Applied" "Theme applied to: Kitty, Waybar, Hyprland, Neovim, Rofi (Doom Emacs unchanged)" -t 4000
}

# Apply selected theme
if [ -n "$CHOSEN" ]; then
    apply_theme "$CHOSEN"
fi