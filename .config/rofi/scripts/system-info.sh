#!/bin/bash

# System information display

get_system_info() {
    echo "=== SYSTEM INFORMATION ==="
    echo ""
    
    # OS Information
    if [ -f /etc/os-release ]; then
        echo "🖥️  OS: $(grep '^PRETTY_NAME=' /etc/os-release | cut -d'"' -f2)"
    fi
    
    # Kernel
    echo "🔧 Kernel: $(uname -r)"
    
    # Uptime
    echo "⏰ Uptime: $(uptime -p 2>/dev/null || uptime | cut -d',' -f1 | cut -d' ' -f3-)"
    
    # CPU
    if command -v lscpu >/dev/null 2>&1; then
        echo "💻 CPU: $(lscpu | grep 'Model name:' | cut -d':' -f2 | xargs)"
    fi
    
    # Memory
    if command -v free >/dev/null 2>&1; then
        MEM_INFO=$(free -h | grep '^Mem:')
        TOTAL=$(echo $MEM_INFO | awk '{print $2}')
        USED=$(echo $MEM_INFO | awk '{print $3}')
        echo "🧠 Memory: $USED / $TOTAL"
    fi
    
    # Disk Usage
    echo "💾 Disk Usage:"
    df -h | grep -E '^/dev/' | head -3 | while read line; do
        echo "   $line"
    done
    
    # Battery (if available)
    if [ -d /sys/class/power_supply/BAT0 ]; then
        BAT_CAPACITY=$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null)
        BAT_STATUS=$(cat /sys/class/power_supply/BAT0/status 2>/dev/null)
        echo "🔋 Battery: $BAT_CAPACITY% ($BAT_STATUS)"
    fi
    
    # Network
    if command -v ip >/dev/null 2>&1; then
        echo "🌐 Network:"
        ip addr show | grep -E 'inet ' | grep -v '127.0.0.1' | head -2 | while read line; do
            echo "   $line"
        done
    fi
    
    # GPU (if available)
    if command -v lspci >/dev/null 2>&1; then
        GPU=$(lspci | grep -i vga | head -1 | cut -d':' -f3 | xargs)
        echo "🎮 GPU: $GPU"
    fi
    
    echo ""
    echo "=== WINDOW MANAGER ==="
    if [ -n "$HYPRLAND_INSTANCE_SIGNATURE" ]; then
        echo "🪟 Hyprland (Active)"
    elif [ "$XDG_SESSION_DESKTOP" = "sway" ]; then
        echo "🪟 Sway (Active)"
    else
        echo "🪟 $XDG_CURRENT_DESKTOP"
    fi
}

# Display info in Rofi
get_system_info | rofi -dmenu -i -p "System Info" -config ~/.config/rofi/config.rasi