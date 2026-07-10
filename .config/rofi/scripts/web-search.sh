#!/bin/bash

# Quick Web Search with multiple engines
# Supports Google, DuckDuckGo, StackOverflow, GitHub, etc.

ENGINES="󰍉 Google\n󰬺 DuckDuckGo\n󰉋 StackOverflow\n󰊤 GitHub\n󰝚 YouTube\n󰖰 Wikipedia\n󰔉 Amazon\n󰮮 Gaming\n󰑺 Reddit\n󰖈 Custom URL"

CHOSEN_ENGINE=$(echo -e "$ENGINES" | rofi -dmenu -i -p "Search Engine" -config ~/.config/rofi/config.rasi)

if [ -n "$CHOSEN_ENGINE" ]; then
    # Get search query
    QUERY=$(rofi -dmenu -p "Search query" -config ~/.config/rofi/config.rasi -mesg "Enter your search terms")
    
    if [ -n "$QUERY" ]; then
        # URL encode the query
        ENCODED_QUERY=$(echo "$QUERY" | sed 's/ /%20/g' | sed 's/&/%26/g' | sed 's/+/%2B/g')
        
        case "$CHOSEN_ENGINE" in
            "󰍉 Google")
                URL="https://www.google.com/search?q=$ENCODED_QUERY"
                ;;
            "󰬺 DuckDuckGo")
                URL="https://duckduckgo.com/?q=$ENCODED_QUERY"
                ;;
            "󰉋 StackOverflow")
                URL="https://stackoverflow.com/search?q=$ENCODED_QUERY"
                ;;
            "󰊤 GitHub")
                URL="https://github.com/search?q=$ENCODED_QUERY"
                ;;
            "󰝚 YouTube")
                URL="https://www.youtube.com/results?search_query=$ENCODED_QUERY"
                ;;
            "󰖰 Wikipedia")
                URL="https://en.wikipedia.org/wiki/Special:Search?search=$ENCODED_QUERY"
                ;;
            "󰔉 Amazon")
                URL="https://www.amazon.com/s?k=$ENCODED_QUERY"
                ;;
            "󰮮 Gaming")
                URL="https://www.google.com/search?q=$ENCODED_QUERY+game"
                ;;
            "󰑺 Reddit")
                URL="https://www.reddit.com/search?q=$ENCODED_QUERY"
                ;;
            "󰖈 Custom URL")
                CUSTOM_URL=$(rofi -dmenu -p "Enter URL (use %s for query)" -config ~/.config/rofi/config.rasi)
                if [ -n "$CUSTOM_URL" ]; then
                    URL=$(echo "$CUSTOM_URL" | sed "s/%s/$ENCODED_QUERY/g")
                else
                    exit 0
                fi
                ;;
        esac
        
        # Open URL in default browser
        if command -v xdg-open >/dev/null 2>&1; then
            xdg-open "$URL"
        elif command -v firefox >/dev/null 2>&1; then
            firefox "$URL"
        elif command -v chromium >/dev/null 2>&1; then
            chromium "$URL"
        else
            rofi -e "Could not find a web browser" -config ~/.config/rofi/config.rasi
        fi
        
        notify-send "Searching" "$QUERY on ${CHOSEN_ENGINE:2}"
    fi
fi