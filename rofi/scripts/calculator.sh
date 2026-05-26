#!/bin/bash

# Calculator with history
# Supports basic math and some advanced functions

CALC_HISTORY="$HOME/.cache/rofi_calc_history"
mkdir -p "$(dirname "$CALC_HISTORY")"

# Function to evaluate expression
calculate() {
    local expression="$1"
    
    # Use bc for floating point math
    if command -v bc >/dev/null 2>&1; then
        # Replace common math symbols
        expression=$(echo "$expression" | sed 's/×/*/g' | sed 's/÷/\//g' | sed 's/π/3.14159265359/g')
        
        # Try to calculate with bc
        local result=$(echo "scale=8; $expression" | bc -l 2>/dev/null)
        
        if [ $? -eq 0 ] && [ -n "$result" ]; then
            # Remove trailing zeros and decimal point if not needed
            result=$(echo "$result" | sed '/\./!s/$/.0/' | sed 's/\.0*$//;s/\.\([0-9]*\)0*$/.\1/')
            echo "$result"
        else
            echo "Error"
        fi
    else
        # Fallback to basic shell arithmetic (integer only)
        let result="$expression" 2>/dev/null
        if [ $? -eq 0 ]; then
            echo "$result"
        else
            echo "Error"
        fi
    fi
}

# Main calculator interface
EXPRESSION=$(rofi -dmenu -p "Calculate" -config ~/.config/rofi/config.rasi -mesg "Examples: 2+2, 10*5, sqrt(16), sin(30)")

if [ -n "$EXPRESSION" ]; then
    RESULT=$(calculate "$EXPRESSION")
    
    if [ "$RESULT" != "Error" ]; then
        # Add to history
        echo "$EXPRESSION = $RESULT" >> "$CALC_HISTORY"
        
        # Show result with options
        OPTIONS="󰅪 Copy Result\n󰑯 New Calculation\n󰉋 View History\n󰎚 Add to History"
        ACTION=$(echo -e "$OPTIONS" | rofi -dmenu -i -p "Result: $RESULT" -config ~/.config/rofi/config.rasi)
        
        case "$ACTION" in
            "󰅪 Copy Result")
                if command -v wl-copy >/dev/null 2>&1; then
                    echo "$RESULT" | wl-copy
                elif command -v xclip >/dev/null 2>&1; then
                    echo "$RESULT" | xclip -selection clipboard
                fi
                notify-send "Copied to clipboard" "$RESULT"
                ;;
            "󰑯 New Calculation")
                ~/.config/rofi/scripts/calculator.sh
                ;;
            "󰉋 View History")
                if [ -f "$CALC_HISTORY" ] && [ -s "$CALC_HISTORY" ]; then
                    HISTORY_DISPLAY=$(tail -20 "$CALC_HISTORY" | tac | sed 's/^/ /')
                    echo -e "$HISTORY_DISPLAY" | rofi -dmenu -i -p "Calculation History" -config ~/.config/rofi/config.rasi
                else
                    rofi -e "No calculation history" -config ~/.config/rofi/config.rasi
                fi
                ;;
        esac
    else
        rofi -e "Invalid expression: $EXPRESSION" -config ~/.config/rofi/config.rasi
    fi
fi