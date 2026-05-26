-- LSP keymaps
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go to declaration' })
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'Go to references' })
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'Go to implementation' })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover documentation' })
vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { desc = 'Signature help' })
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename symbol' })
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code actions' })
vim.keymap.set('n', '<leader>f', function() require("conform").format() end, { desc = 'Format buffer' })
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Show diagnostics' })

-- Plugin keymaps (General toggles only, specific plugin logic stays in plugin configs)
vim.keymap.set('n', '<leader>e', '<cmd>Neotree toggle<cr>', { desc = 'Toggle file explorer' })
vim.keymap.set('n', '<leader>gb', '<cmd>GitBlameToggle<cr>', { desc = 'Toggle git blame' })
vim.keymap.set("n", "<Leader>j", ":Neorg journal today<CR>", { desc = "Open daily journal in Neorg" })
vim.keymap.set("n", "<Leader>a", ":Neorg workspace A7R<CR>", { desc = "opens my A7R workspace"})

-- General keymaps
vim.keymap.set('n', '<leader>w', '<cmd>w<cr>', { desc = 'Save' })
vim.keymap.set('n', '<leader>q', '<cmd>q<cr>', { desc = 'Quit' })

-- Move current line or selection up in Normal and Visual modes
vim.keymap.set({"n", "v"}, "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
-- Move current line or selection down in Normal and Visual modes
vim.keymap.set({"n", "v"}, "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })

--mapping the leader+q to the esc key
vim.keymap.set({"n", "i", "v", "t"}, "<A-q>", "<Esc>", { noremap = true, silent = true })
