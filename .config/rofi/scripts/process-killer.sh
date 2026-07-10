#!/bin/bash

# Process Killer with search and filtering
# Shows running processes and allows killing them

# Function to get process list
get_processes() {
    # Use ps for process list
    ps aux --sort=-%cpu | head -20 | while read -r line; do
        # Skip header
        if [[ "$line" =~ ^USER ]]; then
            continue
        fi
        
        # Extract process info
        PID=$(echo "$line" | awk '{print $2}')
        CPU=$(echo "$line" | awk '{print $3}')
        MEM=$(echo "$line" | awk '{print $4}')
        CMD=$(echo "$line" | awk '{for(i=11;i<=NF;i++) printf "%s ", $i; print ""}' | cut -c1-50)
        
        # Skip kernel processes and system processes
        if [[ "$CMD" =~ ^\[.*\]$ ]] || [[ "$CMD" =~ ^(kthreadd|ksoftirqd|migration|rcu_|watchdog|kworker) ]]; then
            continue
        fi
        
        printf "󰐦 %5s | %3s%% | %3s%% | %s\n" "$PID" "$CPU" "$MEM" "$CMD"
    done
}

# Function to get all processes (more comprehensive)
get_all_processes() {
    ps aux --sort=-%cpu | awk 'NR>1 && !/^\[.*\]$/ && !/^(kthreadd|ksoftirqd|migration|rcu_|watchdog|kworker)/ {
        pid=$2; cpu=$3; mem=$4; 
        cmd=""; for(i=11;i<=NF;i++) cmd=cmd $i " "; 
        printf "󰐦 %5s | %3s%% | %3s%% | %s\n", pid, cpu, mem, substr(cmd,1,50)
    }'
}

# Function to kill process
kill_process() {
    local pid="$1"
    local signal="$2"
    
    if kill -"$signal" "$pid" 2>/dev/null; then
        return 0
    else
        return 1
    fi
}

# Main menu
ACTIONS="󰐦 Top CPU Processes\n󰆚 Top Memory Processes\n󰍉 Search Process\n󱓎 All Processes\n󰐦 Quick Kill"

CHOSEN=$(echo -e "$ACTIONS" | rofi -dmenu -i -p "Process Killer" -config ~/.config/rofi/config.rasi)

case "$CHOSEN" in
    "󰐦 Top CPU Processes")
        PROCESS_LIST=$(get_processes)
        if [ -n "$PROCESS_LIST" ]; then
            SELECTED=$(echo -e "$PROCESS_LIST" | rofi -dmenu -i -p "Select process to kill" -config ~/.config/rofi/config.rasi)
            
            if [ -n "$SELECTED" ]; then
                PID=$(echo "$SELECTED" | awk '{print $2}')
                CMD=$(echo "$SELECTED" | cut -d'|' -f4- | sed 's/^[[:space:]]*//')
                
                # Confirm kill
                if rofi -dmenu -i -p "Kill process $PID ($CMD)? (y/N)" -config ~/.config/rofi/config.rasi | grep -qi "^y"; then
                    if kill_process "$PID" "TERM"; then
                        notify-send "Process killed" "PID: $PID ($CMD)"
                        sleep 1
                        # Check if still running
                        if kill -0 "$PID" 2>/dev/null; then
                            # Force kill if still running
                            kill_process "$PID" "KILL"
                            notify-send "Process force killed" "PID: $PID"
                        fi
                    else
                        rofi -e "Failed to kill process $PID" -config ~/.config/rofi/config.rasi
                    fi
                fi
            fi
        else
            rofi -e "No processes found" -config ~/.config/rofi/config.rasi
        fi
        ;;
    "󰆚 Top Memory Processes")
        PROCESS_LIST=$(ps aux --sort=-%mem | head -20 | while read -r line; do
            if [[ "$line" =~ ^USER ]]; then
                continue
            fi
            
            PID=$(echo "$line" | awk '{print $2}')
            CPU=$(echo "$line" | awk '{print $3}')
            MEM=$(echo "$line" | awk '{print $4}')
            CMD=$(echo "$line" | awk '{for(i=11;i<=NF;i++) printf "%s ", $i; print ""}' | cut -c1-50)
            
            if [[ "$CMD" =~ ^\[.*\]$ ]] || [[ "$CMD" =~ ^(kthreadd|ksoftirqd|migration|rcu_|watchdog|kworker) ]]; then
                continue
            fi
            
            printf "󰆚 %5s | %3s%% | %3s%% | %s\n" "$PID" "$CPU" "$MEM" "$CMD"
        done)
        
        if [ -n "$PROCESS_LIST" ]; then
            SELECTED=$(echo -e "$PROCESS_LIST" | rofi -dmenu -i -p "Select process to kill" -config ~/.config/rofi/config.rasi)
            
            if [ -n "$SELECTED" ]; then
                PID=$(echo "$SELECTED" | awk '{print $2}')
                CMD=$(echo "$SELECTED" | cut -d'|' -f4- | sed 's/^[[:space:]]*//')
                
                if rofi -dmenu -i -p "Kill process $PID ($CMD)? (y/N)" -config ~/.config/rofi/config.rasi | grep -qi "^y"; then
                    if kill_process "$PID" "TERM"; then
                        notify-send "Process killed" "PID: $PID ($CMD)"
                    else
                        rofi -e "Failed to kill process $PID" -config ~/.config/rofi/config.rasi
                    fi
                fi
            fi
        fi
        ;;
    "󰍉 Search Process")
        SEARCH_TERM=$(rofi -dmenu -p "Enter process name" -config ~/.config/rofi/config.rasi)
        
        if [ -n "$SEARCH_TERM" ]; then
            PROCESS_LIST=$(ps aux | grep -i "$SEARCH_TERM" | grep -v grep | while read -r line; do
                PID=$(echo "$line" | awk '{print $2}')
                CPU=$(echo "$line" | awk '{print $3}')
                MEM=$(echo "$line" | awk '{print $4}')
                CMD=$(echo "$line" | awk '{for(i=11;i<=NF;i++) printf "%s ", $i; print ""}' | cut -c1-50)
                
                printf "󰍉 %5s | %3s%% | %3s%% | %s\n" "$PID" "$CPU" "$MEM" "$CMD"
            done)
            
            if [ -n "$PROCESS_LIST" ]; then
                SELECTED=$(echo -e "$PROCESS_LIST" | rofi -dmenu -i -p "Select process to kill" -config ~/.config/rofi/config.rasi)
                
                if [ -n "$SELECTED" ]; then
                    PID=$(echo "$SELECTED" | awk '{print $2}')
                    CMD=$(echo "$SELECTED" | cut -d'|' -f4- | sed 's/^[[:space:]]*//')
                    
                    if rofi -dmenu -i -p "Kill process $PID ($CMD)? (y/N)" -config ~/.config/rofi/config.rasi | grep -qi "^y"; then
                        if kill_process "$PID" "TERM"; then
                            notify-send "Process killed" "PID: $PID ($CMD)"
                        else
                            rofi -e "Failed to kill process $PID" -config ~/.config/rofi/config.rasi
                        fi
                    fi
                fi
            else
                rofi -e "No processes found matching '$SEARCH_TERM'" -config ~/.config/rofi/config.rasi
            fi
        fi
        ;;
    "󱓎 All Processes")
        PROCESS_LIST=$(get_all_processes)
        
        if [ -n "$PROCESS_LIST" ]; then
            SELECTED=$(echo -e "$PROCESS_LIST" | rofi -dmenu -i -p "Select process to kill" -config ~/.config/rofi/config.rasi)
            
            if [ -n "$SELECTED" ]; then
                PID=$(echo "$SELECTED" | awk '{print $2}')
                CMD=$(echo "$SELECTED" | cut -d'|' -f4- | sed 's/^[[:space:]]*//')
                
                # Signal selection
                SIGNALS="TERM (15) - Graceful shutdown\nKILL (9) - Force kill\nINT (2) - Interrupt\nHUP (1) - Hang up\nSTOP (19) - Stop"
                SIGNAL=$(echo -e "$SIGNALS" | rofi -dmenu -i -p "Select signal" -config ~/.config/rofi/config.rasi)
                
                case "$SIGNAL" in
                    "TERM (15) - Graceful shutdown")
                        SIGNAL_NUM="TERM"
                        ;;
                    "KILL (9) - Force kill")
                        SIGNAL_NUM="KILL"
                        ;;
                    "INT (2) - Interrupt")
                        SIGNAL_NUM="INT"
                        ;;
                    "HUP (1) - Hang up")
                        SIGNAL_NUM="HUP"
                        ;;
                    "STOP (19) - Stop")
                        SIGNAL_NUM="STOP"
                        ;;
                esac
                
                if [ -n "$SIGNAL_NUM" ]; then
                    if kill_process "$PID" "$SIGNAL_NUM"; then
                        notify-send "Process killed" "PID: $PID ($CMD) with $SIGNAL_NUM"
                    else
                        rofi -e "Failed to kill process $PID with $SIGNAL_NUM" -config ~/.config/rofi/config.rasi
                    fi
                fi
            fi
        fi
        ;;
    "󰐦 Quick Kill")
        # Quick kill by PID
        PID=$(rofi -dmenu -p "Enter PID to kill" -config ~/.config/rofi/config.rasi)
        
        if [ -n "$PID" ] && [[ "$PID" =~ ^[0-9]+$ ]]; then
            if kill -0 "$PID" 2>/dev/null; then
                if rofi -dmenu -i -p "Kill process $PID? (y/N)" -config ~/.config/rofi/config.rasi | grep -qi "^y"; then
                    if kill_process "$PID" "TERM"; then
                        notify-send "Process killed" "PID: $PID"
                    else
                        rofi -e "Failed to kill process $PID" -config ~/.config/rofi/config.rasi
                    fi
                fi
            else
                rofi -e "Process $PID does not exist" -config ~/.config/rofi/config.rasi
            fi
        else
            rofi -e "Invalid PID: $PID" -config ~/.config/rofi/config.rasi
        fi
        ;;
esac