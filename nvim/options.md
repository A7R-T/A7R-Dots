# Neovim Options Guide

This document explains the options in your Neovim setup (`lua/config/options.lua`). They're grouped by category with details on what each does, why it's useful, and trade-offs.

## Indentation and Tabs

- **`vim.opt.tabstop = 2`**: Sets the width of a tab character to 2 spaces. Controls how tabs display (not insertion). Use 2 for modern code; 4 is traditional.

- **`vim.opt.shiftwidth = 2`**: Sets auto-indentation width (e.g., Enter or `>>`). Matches tabstop for consistency.

- **`vim.opt.expandtab = true`**: Converts tabs to spaces on Tab press. Prevents tabs/spaces mixing, avoiding team issues.

- **`vim.opt.smartindent = true`**: Enables syntax-based indentation (e.g., after `{` in C). Speeds coding but can conflict with LSP/formatters.

## Display and UI

- **`vim.opt.number = true`**: Shows absolute line numbers. Essential for navigation (e.g., `:42` jumps to line 42).

- **`vim.opt.relativenumber = true`**: Shows relative line numbers (e.g., 5 above/below). Great for motions like `5j`.

- **`vim.opt.wrap = false`**: Disables line wrapping. Long lines scroll horizontally. Keeps code readable; toggle with `:set wrap`.

- **`vim.opt.scrolloff = 8`**: Keeps 8 lines visible around cursor. Prevents cursor from hitting screen edges.

- **`vim.opt.signcolumn = "yes"`**: Always shows sign column (for diagnostics, git). Prevents layout shifts.

- **`vim.opt.colorcolumn = "80"`**: Vertical line at column 80. Guides line length for readability.

- **`vim.opt.cursorline = true`**: Highlights current line. Eases navigation but can be distracting.

- **`vim.opt.splitbelow = true`**: Horizontal splits open below. More intuitive.

- **`vim.opt.splitright = true`**: Vertical splits open right. More intuitive.

## Files and Backup

- **`vim.opt.swapfile = false`**: Disables swap files. Prevents clutter/conflicts; use undo/backup.

- **`vim.opt.backup = false`**: Disables backup files. Keeps directory clean; undo handles recovery.

- **`vim.opt.undofile = true`**: Enables persistent undo. History survives restarts. Requires undodir.

- **`vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"`**: Sets undo file directory. Keeps organized.

## Search

- **`vim.opt.hlsearch = false`**: Disables search highlighting. Reduces noise; clear with `:nohl`.

- **`vim.opt.incsearch = true`**: Highlights matches as you type. Faster searching.

## Performance

- **`vim.opt.updatetime = 50`**: 50ms update time (default 4000ms). Faster LSP/git updates, but more CPU.

These create a productive setup. Edit `lua/config/options.lua` to tweak. If issues or changes needed, let me know!