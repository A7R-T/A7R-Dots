# Neovim Keymaps Guide

This document explains all the keymaps in your Neovim setup (`lua/config/keymaps.lua`). They're organized by category, with mode, key combo, description, and usage tips. `<leader>` is space (set in `lua/config/lazy.lua`).

## LSP Keymaps (for language server features, use in code files with LSP attached)

- **`gd`** (normal mode): Go to the definition of the symbol under the cursor.  
  Jumps to where a function/variable is defined. Use when you want to see the implementation of something.

- **`gD`** (normal mode): Go to the declaration of the symbol.  
  Similar to definition, but for declarations (e.g., in headers). Use for C/C++ or similar.

- **`gr`** (normal mode): Show all references to the symbol.  
  Opens a list of where it's used. Use to find usages or refactor.

- **`gi`** (normal mode): Go to implementations of the symbol.  
  For interfaces/abstract methods, jumps to concrete implementations. Use in OOP languages.

- **`K`** (normal mode): Show hover documentation for the symbol.  
  Displays info in a popup (e.g., function signature, docs). Use to quickly check details without leaving your position.

- **`<C-k>`** (normal mode): Show signature help.  
  Displays function parameters in a popup. Use inside function calls for hints.

- **`<leader>rn`** (normal mode): Rename the symbol across the project.  
  Prompts for new name and updates all occurrences. Use for refactoring.

- **`<leader>ca`** (normal mode): Show code actions.  
  Offers quick fixes (e.g., add import, fix error). Use on errors or for code improvements.

- **`<leader>f`** (normal mode): Format the current buffer.  
  Auto-indents and styles code. Use after writing messy code.

## Plugin Keymaps (for specific plugins)

- **`<leader>e`** (normal mode): Toggle the file explorer (Neo-tree).  
  Opens/closes the sidebar file tree. Use to navigate files visually.

- **`<leader>ff`** (normal mode): Find files (Telescope).  
  Fuzzy search for files in project. Use to open files quickly.

- **`<leader>fg`** (normal mode): Live grep (Telescope).  
  Search for text across files. Use to find code or strings.

- **`<leader>fb`** (normal mode): Find buffers (Telescope).  
  List open buffers. Use to switch between files.

- **`<leader>fh`** (normal mode): Help tags (Telescope).  
  Search Neovim help. Use for documentation.

- **`<leader>gb`** (normal mode): Toggle git blame.  
  Shows/hides git blame info per line. Use to see who last changed code.

## General Keymaps

- **`<leader>w`** (normal mode): Save the current file.  
  Equivalent to `:w`. Use frequently to save changes.

- **`<leader>q`** (normal mode): Quit Neovim.  
  Equivalent to `:q`. Use to exit.

## Notes
- These keymaps are efficient and follow Neovim conventions.
- Test them in different contexts (e.g., LSP in code, Telescope for search).
- For completion, `<Tab>`/`<S-Tab>` navigate suggestions/snippets, `<CR>` confirms.
- If you want to change any keymaps, edit `lua/config/keymaps.lua`.
