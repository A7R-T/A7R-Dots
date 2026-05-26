#!/bin/bash

# A7R-OS Master Installer
# Identity: Authentic7Romany (A7R)
# Target: Arch Linux / CachyOS

set -e

# Colors for the vibe
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}--- A7R-OS DOTFILES DEPLOYMENT ---${NC}"

# 1. Check for Stow
if ! command -v stow &> /dev/null; then
    echo -e "${RED}[!] GNU Stow not found. Installing...${NC}"
    sudo pacman -S --needed stow
fi

# 2. Package Installation (The Core Stack)
echo -e "${BLUE}[*] Syncing Core Engine...${NC}"
PACKAGES=(
    hyprland waybar rofi-wayland kitty thunar 
    fastfetch neovim zsh pipewire wireplumber
    ttf-jetbrains-mono-nerd otf-hermit-nerd
    grim slurp wl-clipboard nwg-look kvantum
)

sudo pacman -S --needed "${PACKAGES[@]}"

# 3. Deploying Dotfiles via Stow
echo -e "${BLUE}[*] Linking A7R Soul to Home...${NC}"
# We stow from the repo directory to the home directory
DOT_COMPONENTS=("hypr" "waybar" "rofi" "kitty" "zsh" "fastfetch")

for component in "${DOT_COMPONENTS[@]}"; do
    echo "Stowing $component..."
    # Ensure target directory exists in .config
    mkdir -p "$HOME/.config/$component"
    # Stow will symlink the contents
    stow -v -R -t "$HOME/.config/$component" "$component"
done

# Special handling for Zsh files in $HOME
stow -v -R -t "$HOME" zsh

# 4. System Branding
echo -e "${BLUE}[*] Injecting A7R-OS Identity...${NC}"
sudo hostnamectl set-hostname A7R-OS
sudo sed -i 's/PRETTY_NAME=.*/PRETTY_NAME="A7R-OS"/' /etc/os-release
sudo sed -i 's/NAME=.*/NAME="A7R-OS"/' /etc/os-release

# 5. Icons and Binaries
echo -e "${BLUE}[*] Finalizing Assets...${NC}"
mkdir -p ~/.local/share/icons
cp -r icons/A7R-Cursor ~/.local/share/icons/ 2>/dev/null || true
mkdir -p ~/.local/bin
cp bin/* ~/.local/bin/

echo -e "${BLUE}--- A7R-OS ESTABLISHED ---${NC}"
echo "Restart Hyprland (Super+Escape) to see changes."
