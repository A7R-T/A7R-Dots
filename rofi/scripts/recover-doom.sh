#!/bin/bash

# Doom Emacs recovery script

echo "🔧 Recovering Doom Emacs configuration..."

CONFIG_DIR="$HOME/.config/doom"
CONFIG_FILE="$CONFIG_DIR/config.el"
BACKUP_FILE="$CONFIG_DIR/backup-config.el"

# If there's a backup, restore it
if [ -f "$BACKUP_FILE" ]; then
    echo "📋 Restoring backup configuration..."
    cp "$BACKUP_FILE" "$CONFIG_FILE"
else
    echo "⚠️ No backup found, creating safe configuration..."
    cat > "$CONFIG_FILE" << 'EOF'
;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Font configuration
(setq doom-font (font-spec :family "Hurmit Nerd Font" :size 14))

;; Load custom themes
(add-to-list 'custom-theme-load-path (expand-file-name "themes" doom-private-dir))

;; Set safe default theme
(setq doom-theme 'a7r)

;; Transparency settings
(set-frame-parameter (selected-frame) 'alpha-background 73)
(add-to-list 'default-frame-alist '(alpha-background . 73))

;; Line numbers
(setq display-line-numbers-type 'relative)

;; Org directory
(setq org-directory "~/A7R/A7R-SB/")

;; Enable fancy bullets in Org-mode
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

;; Keybindings
(map! :leader "e" #'neotree-toggle)
(map! (:after evil :i "M-q" #'evil-normal-state))
(map! :leader "j" 'save-buffer)
(map! :leader "q" 'kill-current-buffer)

;; Ensure proper color support for terminal
(setenv "TERM" "xterm-256color")
(setenv "COLORTERM" "truecolor")
EOF
fi

echo "✅ Configuration restored!"
echo ""
echo "To fix Doom Emacs completely:"
echo "1. doom sync"
echo "2. doom restart"
echo ""
echo "Your theme switcher will now work more safely."