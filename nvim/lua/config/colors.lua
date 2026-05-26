-- Sovereign Monochrome Palette (A7R-SB)
local p = {
  bg = "NONE",
  fg = "#8fb8d5",
  -- Dark tones (low contrast)
  dark0 = "#192B3A",
  dark1 = "#2a3b4a",
  dark2 = "#3E6383",
  -- Mid tones
  mid0 = "#4C7B9D",
  mid1 = "#507FA3",
  -- Bright tones (highlights)
  bright0 = "#6399C0",
  bright1 = "#669BC1",
  bright2 = "#6DA6CE",
  bright3 = "#8fb8d5",
}

-- 1. BASE UI
vim.api.nvim_set_hl(0, "Normal", { fg = p.fg, bg = p.bg })
vim.api.nvim_set_hl(0, "NormalNC", { fg = p.fg, bg = p.bg })
vim.api.nvim_set_hl(0, "FloatBorder", { fg = p.mid0, bg = p.bg })
vim.api.nvim_set_hl(0, "NormalFloat", { fg = p.fg, bg = p.bg })
vim.api.nvim_set_hl(0, "Cursor", { fg = p.fg, bg = p.bright1 })
vim.api.nvim_set_hl(0, "Visual", { bg = p.mid0, fg = "NONE" })
vim.api.nvim_set_hl(0, "Search", { bg = p.bright0, fg = p.dark0 })
vim.api.nvim_set_hl(0, "IncSearch", { bg = p.bright2, fg = p.dark0 })
vim.api.nvim_set_hl(0, "LineNr", { fg = p.dark2 })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = p.bright3, bold = true })
vim.api.nvim_set_hl(0, "CursorLine", { bg = p.dark1 })
vim.api.nvim_set_hl(0, "ColorColumn", { bg = p.dark1 })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = p.dark2 })
vim.api.nvim_set_hl(0, "VertSplit", { fg = p.dark1, bg = "NONE" })
vim.api.nvim_set_hl(0, "WinSeparator", { fg = p.dark1, bg = "NONE" })
vim.api.nvim_set_hl(0, "Pmenu", { bg = p.dark0, fg = p.fg })
vim.api.nvim_set_hl(0, "PmenuSel", { bg = p.mid0, fg = p.fg })
vim.api.nvim_set_hl(0, "PmenuSbar", { bg = p.dark1 })
vim.api.nvim_set_hl(0, "PmenuThumb", { bg = p.mid1 })
vim.api.nvim_set_hl(0, "Question", { fg = p.bright2 })
vim.api.nvim_set_hl(0, "Folded", { bg = p.dark1, fg = p.mid1 })
vim.api.nvim_set_hl(0, "FoldColumn", { bg = "NONE", fg = p.mid1 })

-- 2. SYNTAX (Standard)
vim.api.nvim_set_hl(0, "Comment", { fg = p.dark2, italic = true })
vim.api.nvim_set_hl(0, "Constant", { fg = p.bright0 })
vim.api.nvim_set_hl(0, "String", { fg = p.bright0 })
vim.api.nvim_set_hl(0, "Character", { fg = p.bright0 })
vim.api.nvim_set_hl(0, "Number", { fg = p.mid1 })
vim.api.nvim_set_hl(0, "Boolean", { fg = p.bright1 })
vim.api.nvim_set_hl(0, "Float", { fg = p.mid1 })
vim.api.nvim_set_hl(0, "Identifier", { fg = p.mid0 })
vim.api.nvim_set_hl(0, "Function", { fg = p.bright2 })
vim.api.nvim_set_hl(0, "Statement", { fg = p.bright1 })
vim.api.nvim_set_hl(0, "Conditional", { fg = p.bright1 })
vim.api.nvim_set_hl(0, "Repeat", { fg = p.bright1 })
vim.api.nvim_set_hl(0, "Label", { fg = p.bright1 })
vim.api.nvim_set_hl(0, "Operator", { fg = p.fg })
vim.api.nvim_set_hl(0, "Keyword", { fg = p.bright1 })
vim.api.nvim_set_hl(0, "Exception", { fg = p.mid1 })
vim.api.nvim_set_hl(0, "PreProc", { fg = p.bright1 })
vim.api.nvim_set_hl(0, "Include", { fg = p.bright1 })
vim.api.nvim_set_hl(0, "Define", { fg = p.bright1 })
vim.api.nvim_set_hl(0, "Macro", { fg = p.bright1 })
vim.api.nvim_set_hl(0, "Type", { fg = p.mid1 })
vim.api.nvim_set_hl(0, "StorageClass", { fg = p.mid1 })
vim.api.nvim_set_hl(0, "Structure", { fg = p.mid1 })
vim.api.nvim_set_hl(0, "Typedef", { fg = p.mid1 })
vim.api.nvim_set_hl(0, "Special", { fg = p.bright2 })
vim.api.nvim_set_hl(0, "Underlined", { underline = true })
vim.api.nvim_set_hl(0, "Error", { fg = p.bright3, bg = p.dark2 })
vim.api.nvim_set_hl(0, "Todo", { fg = p.bright1, bold = true })

-- 3. TREESITTER (Modern Syntax)
vim.api.nvim_set_hl(0, "@comment", { link = "Comment" })
vim.api.nvim_set_hl(0, "@string", { link = "String" })
vim.api.nvim_set_hl(0, "@keyword", { link = "Keyword" })
vim.api.nvim_set_hl(0, "@function", { link = "Function" })
vim.api.nvim_set_hl(0, "@function.call", { link = "Function" })
vim.api.nvim_set_hl(0, "@variable", { fg = p.fg })
vim.api.nvim_set_hl(0, "@variable.builtin", { fg = p.mid1 })
vim.api.nvim_set_hl(0, "@constant", { link = "Constant" })
vim.api.nvim_set_hl(0, "@constant.builtin", { fg = p.bright1 })
vim.api.nvim_set_hl(0, "@constructor", { fg = p.bright2 })
vim.api.nvim_set_hl(0, "@parameter", { fg = p.mid0 })
vim.api.nvim_set_hl(0, "@property", { fg = p.mid0 })
vim.api.nvim_set_hl(0, "@field", { fg = p.mid0 })
vim.api.nvim_set_hl(0, "@type", { link = "Type" })
vim.api.nvim_set_hl(0, "@type.builtin", { link = "Type" })
vim.api.nvim_set_hl(0, "@operator", { link = "Operator" })
vim.api.nvim_set_hl(0, "@punctuation.delimiter", { fg = p.dark2 })
vim.api.nvim_set_hl(0, "@punctuation.bracket", { fg = p.fg })
vim.api.nvim_set_hl(0, "@tag", { fg = p.bright1 })
vim.api.nvim_set_hl(0, "@tag.attribute", { fg = p.mid0 })
vim.api.nvim_set_hl(0, "@tag.delimiter", { fg = p.dark2 })

-- 4. LSP DIAGNOSTICS
vim.api.nvim_set_hl(0, "DiagnosticError", { fg = p.dark2 })
vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = p.mid1 })
vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = p.bright0 })
vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = p.mid0 })
vim.api.nvim_set_hl(0, "DiagnosticSignError", { fg = p.dark2 })
vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { fg = p.mid1 })
vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { fg = p.bright0 })
vim.api.nvim_set_hl(0, "DiagnosticSignHint", { fg = p.mid0 })

-- 5. GIT (THE FIX)
-- Gitsigns
vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = p.bright2 })
vim.api.nvim_set_hl(0, "GitSignsChange", { fg = p.bright0 })
vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = p.dark2 })
vim.api.nvim_set_hl(0, "GitSignsAddLn", { bg = p.dark1 })
vim.api.nvim_set_hl(0, "GitSignsChangeLn", { bg = p.dark1 })
-- NeoTree Git indicators (Remove Orange/Red)
vim.api.nvim_set_hl(0, "NeoTreeGitAdded", { fg = p.bright2 })
vim.api.nvim_set_hl(0, "NeoTreeGitModified", { fg = p.bright0 })
vim.api.nvim_set_hl(0, "NeoTreeGitDeleted", { fg = p.dark2 })
vim.api.nvim_set_hl(0, "NeoTreeGitRenamed", { fg = p.bright1 })
vim.api.nvim_set_hl(0, "NeoTreeGitUntracked", { fg = p.mid0 })
vim.api.nvim_set_hl(0, "NeoTreeGitIgnored", { fg = p.dark2 })
vim.api.nvim_set_hl(0, "NeoTreeGitConflict", { fg = p.bright3, bold = true })

-- 6. PLUGINS
-- NeoTree
vim.api.nvim_set_hl(0, "NeoTreeDirectoryIcon", { fg = p.mid0 })
vim.api.nvim_set_hl(0, "NeoTreeDirectoryName", { fg = p.mid0 })
vim.api.nvim_set_hl(0, "NeoTreeFileName", { fg = p.fg })
vim.api.nvim_set_hl(0, "NeoTreeRootName", { fg = p.bright2, bold = true })
vim.api.nvim_set_hl(0, "NeoTreeIndentMarker", { fg = p.dark2 })
vim.api.nvim_set_hl(0, "NeoTreeExpander", { fg = p.dark2 })

-- Telescope
vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = p.dark2 })
vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = p.bright1 })
vim.api.nvim_set_hl(0, "TelescopePromptPrefix", { fg = p.bright2 })
vim.api.nvim_set_hl(0, "TelescopeSelection", { bg = p.dark1, fg = p.bright3 })
vim.api.nvim_set_hl(0, "TelescopeSelectionCaret", { fg = p.bright2 })

-- Indent Blankline
vim.api.nvim_set_hl(0, "IblIndent", { fg = p.dark1 })
vim.api.nvim_set_hl(0, "IblWhitespace", { fg = p.dark1 })
vim.api.nvim_set_hl(0, "IblScope", { fg = p.mid0 })

-- Alpha (Dashboard)
vim.api.nvim_set_hl(0, "AlphaHeader", { fg = p.bright2 })
vim.api.nvim_set_hl(0, "AlphaButtons", { fg = p.mid1 })
vim.api.nvim_set_hl(0, "AlphaShortcut", { fg = p.bright1 })
vim.api.nvim_set_hl(0, "AlphaFooter", { fg = p.dark2, italic = true })

-- Nvim-Cmp (Completion)
vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = p.dark2, strikethrough = true })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = p.bright2, bold = true })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = p.bright2, bold = true })
vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = p.dark2 })

-- Kind Colors (Monochrome Mapping)
local kinds = {
  "Text", "Method", "Function", "Constructor", "Field", "Variable", "Class",
  "Interface", "Module", "Property", "Unit", "Value", "Enum", "Keyword",
  "Snippet", "Color", "File", "Reference", "Folder", "EnumMember",
  "Constant", "Struct", "Event", "Operator", "TypeParameter"
}
for _, kind in ipairs(kinds) do
  vim.api.nvim_set_hl(0, "CmpItemKind" .. kind, { fg = p.mid1 })
end

-- DevIcon Overrides (Force Monochrome)
vim.api.nvim_set_hl(0, "DevIconDefault", { fg = p.fg })
vim.api.nvim_set_hl(0, "DevIconDirectory", { fg = p.mid0 })

-- 7. TERMINAL COLORS
vim.g.terminal_color_0 = p.dark0
vim.g.terminal_color_1 = p.dark2
vim.g.terminal_color_2 = p.mid0
vim.g.terminal_color_3 = p.mid1
vim.g.terminal_color_4 = p.bright0
vim.g.terminal_color_5 = p.bright1
vim.g.terminal_color_6 = p.bright2
vim.g.terminal_color_7 = p.fg
vim.g.terminal_color_8 = p.dark1
vim.g.terminal_color_9 = p.dark2
vim.g.terminal_color_10 = p.mid0
vim.g.terminal_color_11 = p.mid1
vim.g.terminal_color_12 = p.bright0
vim.g.terminal_color_13 = p.bright1
vim.g.terminal_color_14 = p.bright2
vim.g.terminal_color_15 = p.bright3
