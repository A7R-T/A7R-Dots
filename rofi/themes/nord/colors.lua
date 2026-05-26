-- Nord terminal colors for Neovim - Full 256-color palette
vim.g.terminal_color_0 = "#3B4252"
vim.g.terminal_color_1 = "#BF616A"
vim.g.terminal_color_2 = "#A3BE8C"
vim.g.terminal_color_3 = "#EBCB8B"
vim.g.terminal_color_4 = "#81A1C1"
vim.g.terminal_color_5 = "#B48EAD"
vim.g.terminal_color_6 = "#88C0D0"
vim.g.terminal_color_7 = "#E5E9F0"
vim.g.terminal_color_8 = "#4C566A"
vim.g.terminal_color_9 = "#BF616A"
vim.g.terminal_color_10 = "#A3BE8C"
vim.g.terminal_color_11 = "#EBCB8B"
vim.g.terminal_color_12 = "#81A1C1"
vim.g.terminal_color_13 = "#B48EAD"
vim.g.terminal_color_14 = "#8FBCBB"
vim.g.terminal_color_15 = "#ECEFF4"

-- Extended Nord colors for complete coverage
vim.g.terminal_color_16 = "#D08770"
vim.g.terminal_color_17 = "#BF616A"
vim.g.terminal_color_18 = "#434C5E"
vim.g.terminal_color_19 = "#4C566A"
vim.g.terminal_color_20 = "#5E81AC"
vim.g.terminal_color_21 = "#81A1C1"
vim.g.terminal_color_22 = "#88C0D0"
vim.g.terminal_color_23 = "#8FBCBB"
vim.g.terminal_color_24 = "#4C566A"
vim.g.terminal_color_25 = "#BF616A"
vim.g.terminal_color_26 = "#A3BE8C"
vim.g.terminal_color_27 = "#EBCB8B"
vim.g.terminal_color_28 = "#81A1C1"
vim.g.terminal_color_29 = "#B48EAD"
vim.g.terminal_color_30 = "#8FBCBB"
vim.g.terminal_color_31 = "#ECEFF4"

-- Additional Nord colors to ensure complete coverage
for i = 32, 255 do
    -- Map all remaining colors to appropriate Nord equivalents
    local color_map = {
        [32] = "#3B4252", [33] = "#3B4252", [34] = "#4C566A", [35] = "#4C566A",
        [36] = "#5E81AC", [37] = "#5E81AC", [38] = "#88C0D0", [39] = "#88C0D0",
        [40] = "#4C566A", [41] = "#4C566A", [42] = "#BF616A", [43] = "#BF616A",
        [44] = "#A3BE8C", [45] = "#A3BE8C", [46] = "#EBCB8B", [47] = "#EBCB8B",
        [48] = "#81A1C1", [49] = "#81A1C1", [50] = "#B48EAD", [51] = "#B48EAD",
        [52] = "#8FBCBB", [53] = "#8FBCBB", [54] = "#ECEFF4", [55] = "#ECEFF4",
    }
    
    if color_map[i] then
        vim.g["terminal_color_" .. i] = color_map[i]
    else
        -- Default pattern for remaining colors
        local base_colors = {"#3B4252", "#4C566A", "#5E81AC", "#88C0D0", "#A3BE8C", "#EBCB8B", "#BF616A", "#B48EAD", "#ECEFF4"}
        vim.g["terminal_color_" .. i] = base_colors[(i % #base_colors) + 1]
    end
end

-- Set background and foreground (keeping transparency)
vim.api.nvim_set_hl(0, "Normal", { fg = "#D8DEE9", bg = "NONE" })

-- Treesitter syntax highlighting (Nord colors)
vim.api.nvim_set_hl(0, "@comment", { fg = "#616E88", italic = true })
vim.api.nvim_set_hl(0, "@string", { fg = "#A3BE8C" })
vim.api.nvim_set_hl(0, "@keyword", { fg = "#81A1C1", bold = true })
vim.api.nvim_set_hl(0, "@function", { fg = "#88C0D0" })
vim.api.nvim_set_hl(0, "@function.call", { fg = "#88C0D0" })
vim.api.nvim_set_hl(0, "@function.builtin", { fg = "#88C0D0" })
vim.api.nvim_set_hl(0, "@method", { fg = "#88C0D0" })
vim.api.nvim_set_hl(0, "@method.call", { fg = "#88C0D0" })
vim.api.nvim_set_hl(0, "@type", { fg = "#81A1C1" })
vim.api.nvim_set_hl(0, "@type.builtin", { fg = "#81A1C1" })
vim.api.nvim_set_hl(0, "@variable", { fg = "#D8DEE9" })
vim.api.nvim_set_hl(0, "@constant", { fg = "#5E81AC" })
vim.api.nvim_set_hl(0, "@number", { fg = "#B48EAD" })
vim.api.nvim_set_hl(0, "@boolean", { fg = "#81A1C1" })
vim.api.nvim_set_hl(0, "@operator", { fg = "#81A1C1" })
vim.api.nvim_set_hl(0, "@punctuation", { fg = "#ECEFF4" })
vim.api.nvim_set_hl(0, "@tag", { fg = "#81A1C1" })
vim.api.nvim_set_hl(0, "@tag.delimiter", { fg = "#4C566A" })
vim.api.nvim_set_hl(0, "@attribute", { fg = "#EBCB8B" })
vim.api.nvim_set_hl(0, "@property", { fg = "#D8DEE9" })
vim.api.nvim_set_hl(0, "@parameter", { fg = "#D8DEE9" })
vim.api.nvim_set_hl(0, "@field", { fg = "#D8DEE9" })
vim.api.nvim_set_hl(0, "@constructor", { fg = "#88C0D0" })
vim.api.nvim_set_hl(0, "@module", { fg = "#81A1C1" })
vim.api.nvim_set_hl(0, "@namespace", { fg = "#81A1C1" })
vim.api.nvim_set_hl(0, "@class", { fg = "#81A1C1" })
vim.api.nvim_set_hl(0, "@struct", { fg = "#81A1C1" })
vim.api.nvim_set_hl(0, "@interface", { fg = "#81A1C1" })
vim.api.nvim_set_hl(0, "@enum", { fg = "#81A1C1" })
vim.api.nvim_set_hl(0, "@enumMember", { fg = "#B48EAD" })
vim.api.nvim_set_hl(0, "@event", { fg = "#88C0D0" })
vim.api.nvim_set_hl(0, "@decorator", { fg = "#EBCB8B" })
vim.api.nvim_set_hl(0, "@macro", { fg = "#B48EAD" })
vim.api.nvim_set_hl(0, "@exception", { fg = "#BF616A" })
vim.api.nvim_set_hl(0, "@conditional", { fg = "#81A1C1" })
vim.api.nvim_set_hl(0, "@repeat", { fg = "#81A1C1" })
vim.api.nvim_set_hl(0, "@label", { fg = "#81A1C1" })
vim.api.nvim_set_hl(0, "@include", { fg = "#81A1C1" })
vim.api.nvim_set_hl(0, "@preproc", { fg = "#5E81AC" })
vim.api.nvim_set_hl(0, "@define", { fg = "#5E81AC" })
vim.api.nvim_set_hl(0, "@storageclass", { fg = "#81A1C1" })
vim.api.nvim_set_hl(0, "@type.qualifier", { fg = "#81A1C1" })
vim.api.nvim_set_hl(0, "@character", { fg = "#A3BE8C" })
vim.api.nvim_set_hl(0, "@escape", { fg = "#EBCB8B" })
vim.api.nvim_set_hl(0, "@regexp", { fg = "#EBCB8B" })
vim.api.nvim_set_hl(0, "@symbol", { fg = "#D8DEE9" })
vim.api.nvim_set_hl(0, "@text", { fg = "#D8DEE9" })
vim.api.nvim_set_hl(0, "@text.strong", { fg = "#D8DEE9", bold = true })
vim.api.nvim_set_hl(0, "@text.emphasis", { fg = "#D8DEE9", italic = true })
vim.api.nvim_set_hl(0, "@text.underline", { fg = "#D8DEE9", underline = true })
vim.api.nvim_set_hl(0, "@text.strike", { fg = "#D8DEE9", strikethrough = true })
vim.api.nvim_set_hl(0, "@text.literal", { fg = "#A3BE8C" })
vim.api.nvim_set_hl(0, "@text.reference", { fg = "#88C0D0" })
vim.api.nvim_set_hl(0, "@text.uri", { fg = "#88C0D0" })
vim.api.nvim_set_hl(0, "@text.math", { fg = "#B48EAD" })
vim.api.nvim_set_hl(0, "@text.environment", { fg = "#81A1C1" })
vim.api.nvim_set_hl(0, "@text.environment.name", { fg = "#88C0D0" })
vim.api.nvim_set_hl(0, "@text.note", { fg = "#616E88" })
vim.api.nvim_set_hl(0, "@text.warning", { fg = "#EBCB8B" })
vim.api.nvim_set_hl(0, "@text.danger", { fg = "#BF616A" })
vim.api.nvim_set_hl(0, "@text.todo", { fg = "#EBCB8B" })

-- Fallback Vim syntax highlighting
vim.api.nvim_set_hl(0, "Comment", { fg = "#616E88", italic = true })
vim.api.nvim_set_hl(0, "String", { fg = "#A3BE8C" })
vim.api.nvim_set_hl(0, "Keyword", { fg = "#81A1C1", bold = true })
vim.api.nvim_set_hl(0, "Function", { fg = "#88C0D0" })
vim.api.nvim_set_hl(0, "Type", { fg = "#81A1C1" })
vim.api.nvim_set_hl(0, "Identifier", { fg = "#D8DEE9" })

-- UI elements
vim.api.nvim_set_hl(0, "Cursor", { fg = "#2E3440", bg = "#D8DEE9" })
vim.api.nvim_set_hl(0, "Visual", { bg = "#4C566A" })
vim.api.nvim_set_hl(0, "LineNr", { fg = "#4C566A" })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#D8DEE9" })
vim.api.nvim_set_hl(0, "StatusLine", { bg = "#3B4252", fg = "#D8DEE9" })
vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "#4C566A", fg = "#D8DEE9" })
vim.api.nvim_set_hl(0, "CursorLine", { bg = "#3B4252" })
vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#3B4252" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = "#4C566A" })

-- NeoTree highlights
vim.api.nvim_set_hl(0, "NeoTreeDirectoryIcon", { fg = "#81A1C1" })
vim.api.nvim_set_hl(0, "NeoTreeFileIcon", { fg = "#D8DEE9" })
vim.api.nvim_set_hl(0, "NeoTreeRootName", { fg = "#88C0D0" })
vim.api.nvim_set_hl(0, "NeoTreeDirectoryName", { fg = "#81A1C1" })
vim.api.nvim_set_hl(0, "NeoTreeFileName", { fg = "#D8DEE9" })
vim.api.nvim_set_hl(0, "NeoTreeIndentMarker", { fg = "#4C566A" })
vim.api.nvim_set_hl(0, "NeoTreeSymlink", { fg = "#88C0D0" })
vim.api.nvim_set_hl(0, "NeoTreeExecFile", { fg = "#A3BE8C" })