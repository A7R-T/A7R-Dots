#!/usr/bin/env bash

sleep 3
systemctl --user reset-failed

dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=Hyprland
systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP

killall -q xdg-desktop-portal-hyprland
killall -q xdg-desktop-portal

systemctl --user start xdg-desktop-portal-hyprland
/usr/lib/xdg-desktop-portal --replace &
