#!/bin/bash

# Bluetooth control menu

check_bluetooth() {
    if ! command -v bluetoothctl >/dev/null 2>&1; then
        rofi -e "bluetoothctl not found. Install bluez-utils." -config ~/.config/rofi/config.rasi
        exit 1
    fi
}

get_bluetooth_status() {
    bluetoothctl show | grep "Powered:" | awk '{print $2}'
}

get_connected_devices() {
    bluetoothctl devices Connected | grep -E "Device" | awk '{for(i=3;i<=NF;i++) printf $i" "; print ""}' | sed 's/ $//'
}

get_all_devices() {
    bluetoothctl devices | grep -E "Device" | awk '{for(i=3;i<=NF;i++) printf $i" "; print ""}' | sed 's/ $//'
}

get_device_battery() {
    local device="$1"
    local mac=$(bluetoothctl devices | grep "$device" | awk '{print $2}')
    if [ -n "$mac" ]; then
        battery=$(bluetoothctl info "$mac" 2>/dev/null | grep "Battery Percentage" | awk -F'[(%)]' '{print $2}')
        if [ -n "$battery" ]; then
            echo " ($battery%)"
        fi
    fi
}

toggle_bluetooth() {
    local status=$(get_bluetooth_status)
    if [ "$status" = "yes" ]; then
        bluetoothctl power off
        notify-send "Bluetooth turned off"
    else
        bluetoothctl power on
        notify-send "Bluetooth turned on"
    fi
}

connect_device() {
    local device="$1"
    local mac=$(bluetoothctl devices | grep "$device" | awk '{print $2}')
    if [ -n "$mac" ]; then
        bluetoothctl connect "$mac" >/dev/null 2>&1
        if [ $? -eq 0 ]; then
            notify-send "Connected to $device"
        else
            rofi -e "Failed to connect to $device" -config ~/.config/rofi/config.rasi
        fi
    fi
}

disconnect_device() {
    local device="$1"
    local mac=$(bluetoothctl devices | grep "$device" | awk '{print $2}')
    if [ -n "$mac" ]; then
        bluetoothctl disconnect "$mac" >/dev/null 2>&1
        if [ $? -eq 0 ]; then
            notify-send "Disconnected from $device"
        else
            rofi -e "Failed to disconnect from $device" -config ~/.config/rofi/config.rasi
        fi
    fi
}

scan_and_pair() {
    # Start scanning
    bluetoothctl scan on >/dev/null 2>&1 &
    local scan_pid=$!
    
    # Show scanning rofi dialog
    (for i in {1..10}; do echo "Scanning... ($i/10)"; sleep 1; done) | \
    rofi -dmenu -i -p "Bluetooth Scanning" -config ~/.config/rofi/config.rasi >/dev/null &
    local rofi_pid=$!
    
    # Wait for scan to complete
    sleep 10
    
    # Stop scanning and clean up
    kill $scan_pid 2>/dev/null
    kill $rofi_pid 2>/dev/null
    bluetoothctl scan off >/dev/null 2>&1
    sleep 1
    
    # Get discovered devices
    DEVICES=$(bluetoothctl devices | grep -E "Device" | awk '{for(i=3;i<=NF;i++) printf $i" "; print ""}' | sed 's/ $//')
    
    if [ -z "$DEVICES" ]; then
        rofi -e "No devices found" -config ~/.config/rofi/config.rasi
        return
    fi
    
    # Show devices in rofi for selection
    DEVICE_LIST=""
    while IFS= read -r device; do
        if [ -n "$device" ]; then
            DEVICE_LIST="${DEVICE_LIST}󰂯 Pair/Connect: ${device}\n"
        fi
    done <<< "$DEVICES"
    
    CHOSEN_DEVICE=$(echo -e "$DEVICE_LIST" | rofi -dmenu -i -p "Select Device" -config ~/.config/rofi/config.rasi)
    
    if [[ "$CHOSEN_DEVICE" == 󰂯\ Pair/Connect:* ]]; then
        DEVICE=$(echo "$CHOSEN_DEVICE" | sed 's/󰂯 Pair\/Connect: //')
        local mac=$(bluetoothctl devices | grep "$DEVICE" | awk '{print $2}')
        
        if [ -n "$mac" ]; then
            # Try to pair and connect
            bluetoothctl pair "$mac" >/dev/null 2>&1
            bluetoothctl connect "$mac" >/dev/null 2>&1
            
            if bluetoothctl info "$mac" | grep -q "Connected: yes"; then
                rofi -e "Successfully connected to $DEVICE" -config ~/.config/rofi/config.rasi
            else
                rofi -e "Failed to connect to $DEVICE" -config ~/.config/rofi/config.rasi
            fi
        fi
    fi
}

check_bluetooth

STATUS=$(get_bluetooth_status)
CONNECTED_DEVICES=$(get_connected_devices)

if [ "$STATUS" = "yes" ]; then
    POWER_ACTION="󰂲 Turn Off Bluetooth"
else
    POWER_ACTION="󰂯 Turn On Bluetooth"
fi

if [ -n "$CONNECTED_DEVICES" ]; then
    CONNECTED_LIST=""
    while IFS= read -r device; do
        if [ -n "$device" ]; then
            BATTERY_INFO=$(get_device_battery "$device")
            CONNECTED_LIST="${CONNECTED_LIST}󰂱 Disconnect: ${device}${BATTERY_INFO}\n"
        fi
    done <<< "$CONNECTED_DEVICES"
else
    CONNECTED_LIST=""
fi

ALL_DEVICES=$(get_all_devices)
AVAILABLE_LIST=""
while IFS= read -r device; do
    if [ -n "$device" ]; then
        if ! echo "$CONNECTED_DEVICES" | grep -q "$device"; then
            AVAILABLE_LIST="${AVAILABLE_LIST}󰂯 Connect: ${device}\n"
        fi
    fi
done <<< "$ALL_DEVICES"

MENU="${POWER_ACTION}\n󰔃 Scan & Pair Devices\n${CONNECTED_LIST}${AVAILABLE_LIST}"

CHOSEN=$(echo -e "$MENU" | rofi -dmenu -i -p "Bluetooth Control" -config ~/.config/rofi/config.rasi)

case "$CHOSEN" in
    "󰂲 Turn Off Bluetooth"|"󰂯 Turn On Bluetooth")
        toggle_bluetooth
        ;;
    "󰔃 Scan & Pair Devices")
        scan_and_pair
        ;;
    󰂱\ Disconnect:*)
        DEVICE=$(echo "$CHOSEN" | sed 's/󰂱 Disconnect: //')
        disconnect_device "$DEVICE"
        ;;
    󰂯\ Connect:*)
        DEVICE=$(echo "$CHOSEN" | sed 's/󰂯 Connect: //')
        connect_device "$DEVICE"
        ;;
esac