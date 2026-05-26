#!/bin/bash

# Enhanced File Search with better filtering
# Uses rofi's built-in filtering for better performance

# Common search directories
SEARCH_DIRS=(
    "$HOME/Documents"
    "$HOME/Downloads"
    "$HOME/Pictures"
    "$HOME/Videos"
    "$HOME/Music"
    "$HOME/Desktop"
    "$HOME/.config"
    "$HOME/Projects"
    "$HOME/workspace"
    "$HOME/src"
    "$HOME"
)

# Function to get files with better filtering
get_files() {
    local all_files=""
    
    for dir in "${SEARCH_DIRS[@]}"; do
        if [ -d "$dir" ]; then
            if command -v fd >/dev/null 2>&1; then
                # Use fd for faster search with better filtering
                local files=$(fd --type file --hidden --follow --exclude .git --exclude node_modules --exclude target --exclude build --exclude dist --exclude __pycache__ --exclude '*.pyc' --exclude '*.log' --max-depth 4 . "$dir" 2>/dev/null)
            else
                # Fallback to find with better filtering
                local files=$(find "$dir" -type f \( -path "*/.git" -o -path "*/node_modules" -o -path "*/target" -o -path "*/build" -o -path "*/dist" -o -path "*/__pycache__" \) -prune -o -type f -print 2>/dev/null)
            fi
            
            if [ -n "$files" ]; then
                all_files="$all_files$files"$'\n'
            fi
        fi
    done
    
    echo "$all_files" | grep -v '^$' | sort -u
}

# Function to open files with appropriate application
open_file() {
    local file="$1"
    
    if [ -n "$file" ] && [ -f "$file" ]; then
        # Open with default application
        if command -v xdg-open >/dev/null 2>&1; then
            xdg-open "$file"
        elif command -v gnome-open >/dev/null 2>&1; then
            gnome-open "$file"
        else
            # Fallback to common applications
            case "${file##*.}" in
                pdf|djvu)
                    zathura "$file" 2>/dev/null || evince "$file" 2>/dev/null &
                    ;;
                txt|md|py|js|html|css|json|xml|yaml|yml|sh|conf|config|cpp|c|h|hpp|rs|go|java|php|rb|swift|kt|scala|clj|lisp|hs|ml|ex|exs|elm|dart|ts|tsx|vue|svelte|jsx|tsx|bash|zsh|fish|ps1|cmd|bat)
                    ${EDITOR:-nano} "$file" &
                    ;;
                jpg|jpeg|png|gif|bmp|svg|webp)
                    feh "$file" 2>/dev/null || eog "$file" 2>/dev/null || sxiv "$file" 2>/dev/null &
                    ;;
                mp4|avi|mkv|webm|mov|flv|wmv)
                    mpv "$file" 2>/dev/null || vlc "$file" 2>/dev/null &
                    ;;
                mp3|flac|wav|ogg|m4a|aac)
                    mpv "$file" 2>/dev/null || vlc "$file" 2>/dev/null &
                    ;;
                *)
                    xdg-open "$file" 2>/dev/null &
                    ;;
            esac
        fi
        
        notify-send "Opening file" "$(basename "$file")"
    fi
}

# Main search function
main() {
    # Get all files first
    echo "Loading files..."
    local files=$(get_files)
    
    if [ -z "$files" ]; then
        rofi -e "No files found in common directories" -config ~/.config/rofi/config.rasi
        exit 0
    fi
    
    # Use rofi's built-in filtering for better performance
    local selected_file=$(echo "$files" | rofi -dmenu -i -p "Search Files" -config ~/.config/rofi/config.rasi -mesg "Type to filter files • $(echo "$files" | wc -l) files indexed")
    
    if [ -n "$selected_file" ]; then
        open_file "$selected_file"
    fi
}

# Start the search
main