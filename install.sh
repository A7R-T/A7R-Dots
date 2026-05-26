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

# 1. Check for Essential Tools
for tool in stow git curl; do
    if ! command -v $tool &> /dev/null; then
        echo -e "${RED}[!] $tool not found. Installing...${NC}"
        sudo pacman -S --needed --noconfirm $tool
    fi
done

# 2. Package Engine (Official & AUR)
echo -e "${BLUE}[*] Initializing Package Engine...${NC}"

# Install Yay (AUR Helper) if not present
if ! command -v yay &> /dev/null; then
    echo "Installing yay..."
    sudo pacman -S --needed base-devel
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay && makepkg -si --noconfirm && cd -
fi

echo -e "${BLUE}[*] Batch Installing Official Packages...${NC}"
# Filter list to ensure no invalid packages stop the process
sudo pacman -S --needed --noconfirm - < official_packages.txt

echo -e "${BLUE}[*] Batch Installing AUR Packages...${NC}"
yay -S --needed --noconfirm - < aur_packages.txt

# 3. Zsh & Shell Environment
echo -e "${BLUE}[*] Setting up Zsh Environment...${NC}"
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Install Zsh Plugins (Autosuggestions & Syntax Highlighting)
ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}
mkdir -p "$ZSH_CUSTOM/plugins"
[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ] && git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
[ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ] && git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
[ ! -d "$ZSH_CUSTOM/plugins/zsh-autocomplete" ] && git clone https://github.com/marlonrichert/zsh-autocomplete "$ZSH_CUSTOM/plugins/zsh-autocomplete"

# 4. Deploying Dotfiles via Stow
echo -e "${BLUE}[*] Linking A7R Soul to Home...${NC}"
DOT_COMPONENTS=("hypr" "waybar" "rofi" "kitty" "fastfetch")

for component in "${DOT_COMPONENTS[@]}"; do
    echo "Stowing $component..."
    mkdir -p "$HOME/.config/$component"
    stow -v -R -t "$HOME/.config/$component" "$component"
done

# Special handling for Zsh files in $HOME
stow -v -R -t "$HOME" zsh

# 5. System Branding
echo -e "${BLUE}[*] Injecting A7R-OS Identity...${NC}"
sudo hostnamectl set-hostname A7R-OS
sudo sed -i 's/PRETTY_NAME=.*/PRETTY_NAME="A7R-OS"/' /etc/os-release
sudo sed -i 's/NAME=.*/NAME="A7R-OS"/' /etc/os-release

# 6. Icons and Binaries
echo -e "${BLUE}[*] Finalizing Assets...${NC}"
mkdir -p ~/.local/share/icons
cp -r icons/A7R-Cursor ~/.local/share/icons/ 2>/dev/null || true
mkdir -p ~/.local/bin
cp bin/* ~/.local/bin/

echo -e "${BLUE}--- A7R-OS ESTABLISHED ---${NC}"
echo "Set Zsh as default: chsh -s \$(which zsh)"
echo "Restart Hyprland (Super+Escape) to see changes."
