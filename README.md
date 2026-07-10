# A7R-dots 🌑

The soul of **A7R-OS**. This repository contains the configuration files and deployment scripts for the Authentic7Romany Arch Linux (Hyprland) rice.

## 🛠 Features
- **Window Manager:** Hyprland (Customized gaps and shadows)
- **Status Bar:** Waybar
- **Terminal:** Kitty (Zsh + Powerlevel10k)
- **Branding:** Fastfetch with A7R-OS identity
- **Optimized for:** AMD Ryzen 5 5600 + RX 6700 XT

## 🚀 Installation
To inject the A7R soul into a fresh Arch/CachyOS install:

```bash
git clone https://github.com/Authentic7Romany/A7R-dots.git
cd A7R-dots
cp -r .config/ ~/
cp -r .local/ ~/
cp -r .themes/ ~/
cp -r heroic-a7r-theme/ ~/
```

### GTK Theme Activation (Hyprland)

Since there's no GNOME/KDE settings daemon, the `xsettingsd` service applies the theme:

```bash
# Make sure xsettingsd is installed
sudo pacman -S xsettingsd

# Copy config if not already present
cp -r .config/xsettingsd/ ~/.config/

# Restart xsettingsd to apply changes
killall xsettingsd && xsettingsd &
```

Add `xsettingsd` to your Hyprland config (`~/.config/hypr/hyprland.conf`) to autostart:

```
exec-once = xsettingsd
```

## ⚖️ License
A7R - All Rights Reserved.
