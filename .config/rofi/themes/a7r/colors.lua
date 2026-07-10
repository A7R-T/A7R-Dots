-- Set terminal colors to match Kitty palette
vim.g.terminal_color_0 = "#3E6383"
vim.g.terminal_color_1 = "#3E6383"
vim.g.terminal_color_2 = "#4C7B9D"
vim.g.terminal_color_3 = "#507FA3"
vim.g.terminal_color_4 = "#6399C0"
vim.g.terminal_color_5 = "#669BC1"
vim.g.terminal_color_6 = "#6DA6CE"
vim.g.terminal_color_7 = "#6DA6CE"
vim.g.terminal_color_8 = "#3E6383"
vim.g.terminal_color_9 = "#3E6383"
vim.g.terminal_color_10 = "#4C7B9D"
vim.g.terminal_color_11 = "#507FA3"
vim.g.terminal_color_12 = "#6399C0"
vim.g.terminal_color_13 = "#669BC1"
vim.g.terminal_color_14 = "#6DA6CE"
vim.g.terminal_color_15 = "#6DA6CE"

-- Set background and foreground (keeping transparency)
vim.api.nvim_set_hl(0, "Normal", { fg = "#8fb8d5", bg = "NONE" })

-- Treesitter syntax highlighting (comprehensive overrides)
vim.api.nvim_set_hl(0, "@comment", { fg = "#4C7B9D" })
vim.api.nvim_set_hl(0, "@string", { fg = "#6399C0" })
vim.api.nvim_set_hl(0, "@keyword", { fg = "#8fb8d5" })
vim.api.nvim_set_hl(0, "@function", { fg = "#6DA6CE" })
vim.api.nvim_set_hl(0, "@function.call", { fg = "#6DA6CE" })
vim.api.nvim_set_hl(0, "@function.builtin", { fg = "#6DA6CE" })
vim.api.nvim_set_hl(0, "@method", { fg = "#6DA6CE" })
vim.api.nvim_set_hl(0, "@method.call", { fg = "#6DA6CE" })
vim.api.nvim_set_hl(0, "@type", { fg = "#507FA3" })
vim.api.nvim_set_hl(0, "@type.builtin", { fg = "#507FA3" })
vim.api.nvim_set_hl(0, "@variable", { fg = "#8fb8d5" })
vim.api.nvim_set_hl(0, "@constant", { fg = "#6399C0" })
vim.api.nvim_set_hl(0, "@number", { fg = "#507FA3" })
vim.api.nvim_set_hl(0, "@boolean", { fg = "#669BC1" })
vim.api.nvim_set_hl(0, "@operator", { fg = "#8fb8d5" })
vim.api.nvim_set_hl(0, "@punctuation", { fg = "#8fb8d5" })
vim.api.nvim_set_hl(0, "@tag", { fg = "#8fb8d5" })
vim.api.nvim_set_hl(0, "@tag.delimiter", { fg = "#3E6383" })
vim.api.nvim_set_hl(0, "@attribute", { fg = "#6399C0" })
vim.api.nvim_set_hl(0, "@property", { fg = "#4C7B9D" })
vim.api.nvim_set_hl(0, "@parameter", { fg = "#4C7B9D" })
vim.api.nvim_set_hl(0, "@field", { fg = "#4C7B9D" })
vim.api.nvim_set_hl(0, "@constructor", { fg = "#6DA6CE" })
vim.api.nvim_set_hl(0, "@module", { fg = "#507FA3" })
vim.api.nvim_set_hl(0, "@namespace", { fg = "#507FA3" })
vim.api.nvim_set_hl(0, "@class", { fg = "#507FA3" })
vim.api.nvim_set_hl(0, "@struct", { fg = "#507FA3" })
vim.api.nvim_set_hl(0, "@interface", { fg = "#507FA3" })
vim.api.nvim_set_hl(0, "@enum", { fg = "#507FA3" })
vim.api.nvim_set_hl(0, "@enumMember", { fg = "#669BC1" })
vim.api.nvim_set_hl(0, "@event", { fg = "#6DA6CE" })
vim.api.nvim_set_hl(0, "@decorator", { fg = "#6DA6CE" })
vim.api.nvim_set_hl(0, "@macro", { fg = "#669BC1" })
vim.api.nvim_set_hl(0, "@exception", { fg = "#507FA3" })
vim.api.nvim_set_hl(0, "@conditional", { fg = "#669BC1" })
vim.api.nvim_set_hl(0, "@repeat", { fg = "#669BC1" })
vim.api.nvim_set_hl(0, "@label", { fg = "#669BC1" })
vim.api.nvim_set_hl(0, "@include", { fg = "#669BC1" })
vim.api.nvim_set_hl(0, "@preproc", { fg = "#669BC1" })
vim.api.nvim_set_hl(0, "@define", { fg = "#669BC1" })
vim.api.nvim_set_hl(0, "@storageclass", { fg = "#669BC1" })
vim.api.nvim_set_hl(0, "@type.qualifier", { fg = "#669BC1" })
vim.api.nvim_set_hl(0, "@character", { fg = "#6399C0" })
vim.api.nvim_set_hl(0, "@escape", { fg = "#6399C0" })
vim.api.nvim_set_hl(0, "@regexp", { fg = "#6399C0" })
vim.api.nvim_set_hl(0, "@symbol", { fg = "#6399C0" })
vim.api.nvim_set_hl(0, "@text", { fg = "#8fb8d5" })
vim.api.nvim_set_hl(0, "@text.strong", { fg = "#8fb8d5", bold = true })
vim.api.nvim_set_hl(0, "@text.emphasis", { fg = "#8fb8d5", italic = true })
vim.api.nvim_set_hl(0, "@text.underline", { fg = "#8fb8d5", underline = true })
vim.api.nvim_set_hl(0, "@text.strike", { fg = "#8fb8d5", strikethrough = true })
vim.api.nvim_set_hl(0, "@text.literal", { fg = "#6399C0" })
vim.api.nvim_set_hl(0, "@text.reference", { fg = "#6399C0" })
vim.api.nvim_set_hl(0, "@text.uri", { fg = "#6399C0" })
vim.api.nvim_set_hl(0, "@text.math", { fg = "#507FA3" })
vim.api.nvim_set_hl(0, "@text.environment", { fg = "#507FA3" })
vim.api.nvim_set_hl(0, "@text.environment.name", { fg = "#6DA6CE" })
vim.api.nvim_set_hl(0, "@text.note", { fg = "#3E6383" })
vim.api.nvim_set_hl(0, "@text.warning", { fg = "#507FA3" })
vim.api.nvim_set_hl(0, "@text.danger", { fg = "#3E6383" })
vim.api.nvim_set_hl(0, "@text.todo", { fg = "#669BC1" })

-- Fallback Vim syntax highlighting
vim.api.nvim_set_hl(0, "Comment", { fg = "#3E6383" })
vim.api.nvim_set_hl(0, "String", { fg = "#6399C0" })
vim.api.nvim_set_hl(0, "Keyword", { fg = "#669BC1" })
vim.api.nvim_set_hl(0, "Function", { fg = "#6DA6CE" })
vim.api.nvim_set_hl(0, "Type", { fg = "#507FA3" })
vim.api.nvim_set_hl(0, "Identifier", { fg = "#4C7B9D" })

-- UI elements
vim.api.nvim_set_hl(0, "Cursor", { fg = "#8fb8d5", bg = "#669BC1" })
vim.api.nvim_set_hl(0, "Visual", { bg = "#4C7B9D" })
vim.api.nvim_set_hl(0, "LineNr", { fg = "#3E6383" })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#8fb8d5" })
vim.api.nvim_set_hl(0, "StatusLine", { bg = "#192B3A", fg = "#8fb8d5" })
vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "#3E6383", fg = "#8fb8d5" })
vim.api.nvim_set_hl(0, "CursorLine", { bg = "#2a3b4a" })
vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#2a3b4a" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = "#3E6383" })
-- NeoTree highlights
vim.api.nvim_set_hl(0, "NeoTreeDirectoryIcon", { fg = "#4C7B9D" })
vim.api.nvim_set_hl(0, "NeoTreeFileIcon", { fg = "#8fb8d5" })
vim.api.nvim_set_hl(0, "NeoTreeRootName", { fg = "#507FA3" })
vim.api.nvim_set_hl(0, "NeoTreeDirectoryName", { fg = "#4C7B9D" })
vim.api.nvim_set_hl(0, "NeoTreeFileName", { fg = "#8fb8d5" })
vim.api.nvim_set_hl(0, "NeoTreeIndentMarker", { fg = "#3E6383" })
vim.api.nvim_set_hl(0, "NeoTreeSymlink", { fg = "#6399C0" })
vim.api.nvim_set_hl(0, "NeoTreeExecFile", { fg = "#6DA6CE" })
