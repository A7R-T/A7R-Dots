#!/bin/bash

# Safe Doom Emacs theme switcher

THEMES="🎨 A7R\n🌨️ A7R Nord\n🌲 A7R Everforest"

CHOSEN=$(echo -e "$THEMES" | rofi -dmenu -i -p "Select Doom Theme" -config ~/.config/rofi/config.rasi)

case "$CHOSEN" in
    "🎨 A7R")
        sed -i 's/(setq doom-theme.*/(setq doom-theme '\''a7r)/' "$HOME/.config/doom/config.el"
        echo "Doom theme set to A7R"
        ;;
    "🌨️ A7R Nord")
        sed -i 's/(setq doom-theme.*/(setq doom-theme '\''a7r-nord)/' "$HOME/.config/doom/config.el"
        echo "Doom theme set to A7R Nord"
        ;;
    "🌲 A7R Everforest")
        sed -i 's/(setq doom-theme.*/(setq doom-theme '\''a7r-everforest)/' "$HOME/.config/doom/config.el"
        echo "Doom theme set to A7R Everforest"
        ;;
esac

notify-send "Doom Theme Updated" "Run: doom sync && doom restart" -t 4000