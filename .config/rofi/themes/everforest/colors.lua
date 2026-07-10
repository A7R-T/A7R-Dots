-- Everforest terminal colors for Neovim - Full 256-color palette
vim.g.terminal_color_0 = "#475258"
vim.g.terminal_color_1 = "#E67E80"
vim.g.terminal_color_2 = "#A7C080"
vim.g.terminal_color_3 = "#DBBC7F"
vim.g.terminal_color_4 = "#7FBBB3"
vim.g.terminal_color_5 = "#D699B6"
vim.g.terminal_color_6 = "#83C092"
vim.g.terminal_color_7 = "#D3C6AA"
vim.g.terminal_color_8 = "#5C6A72"
vim.g.terminal_color_9 = "#E67E80"
vim.g.terminal_color_10 = "#A7C080"
vim.g.terminal_color_11 = "#DBBC7F"
vim.g.terminal_color_12 = "#7FBBB3"
vim.g.terminal_color_13 = "#D699B6"
vim.g.terminal_color_14 = "#83C092"
vim.g.terminal_color_15 = "#EDEAD8"

-- Extended Everforest colors for complete coverage
vim.g.terminal_color_16 = "#E39A6A"
vim.g.terminal_color_17 = "#E67E80"
vim.g.terminal_color_18 = "#3E484D"
vim.g.terminal_color_19 = "#5C6A72"
vim.g.terminal_color_20 = "#7FBBB3"
vim.g.terminal_color_21 = "#83C092"
vim.g.terminal_color_22 = "#A7C080"
vim.g.terminal_color_23 = "#DBBC7F"
vim.g.terminal_color_24 = "#5C6A72"
vim.g.terminal_color_25 = "#E67E80"
vim.g.terminal_color_26 = "#A7C080"
vim.g.terminal_color_27 = "#DBBC7F"
vim.g.terminal_color_28 = "#7FBBB3"
vim.g.terminal_color_29 = "#D699B6"
vim.g.terminal_color_30 = "#83C092"
vim.g.terminal_color_31 = "#EDEAD8"

-- Additional Everforest colors to ensure complete coverage
for i = 32, 255 do
    -- Map all remaining colors to appropriate Everforest equivalents
    local color_map = {
        [32] = "#475258", [33] = "#475258", [34] = "#5C6A72", [35] = "#5C6A72",
        [36] = "#7FBBB3", [37] = "#7FBBB3", [38] = "#A7C080", [39] = "#A7C080",
        [40] = "#5C6A72", [41] = "#5C6A72", [42] = "#E67E80", [43] = "#E67E80",
        [44] = "#A7C080", [45] = "#A7C080", [46] = "#DBBC7F", [47] = "#DBBC7F",
        [48] = "#7FBBB3", [49] = "#7FBBB3", [50] = "#D699B6", [51] = "#D699B6",
        [52] = "#83C092", [53] = "#83C092", [54] = "#EDEAD8", [55] = "#EDEAD8",
    }
    
    if color_map[i] then
        vim.g["terminal_color_" .. i] = color_map[i]
    else
        -- Default pattern for remaining colors
        local base_colors = {"#475258", "#5C6A72", "#7FBBB3", "#A7C080", "#DBBC7F", "#E67E80", "#D699B6", "#83C092", "#EDEAD8"}
        vim.g["terminal_color_" .. i] = base_colors[(i % #base_colors) + 1]
    end
end

-- Set background and foreground (keeping transparency)
vim.api.nvim_set_hl(0, "Normal", { fg = "#D3C6AA", bg = "NONE" })

-- Treesitter syntax highlighting (Everforest colors)
vim.api.nvim_set_hl(0, "@comment", { fg = "#5C6A72", italic = true })
vim.api.nvim_set_hl(0, "@string", { fg = "#A7C080" })
vim.api.nvim_set_hl(0, "@keyword", { fg = "#7FBBB3", bold = true })
vim.api.nvim_set_hl(0, "@function", { fg = "#83C092" })
vim.api.nvim_set_hl(0, "@function.call", { fg = "#83C092" })
vim.api.nvim_set_hl(0, "@function.builtin", { fg = "#83C092" })
vim.api.nvim_set_hl(0, "@method", { fg = "#83C092" })
vim.api.nvim_set_hl(0, "@method.call", { fg = "#83C092" })
vim.api.nvim_set_hl(0, "@type", { fg = "#7FBBB3" })
vim.api.nvim_set_hl(0, "@type.builtin", { fg = "#7FBBB3" })
vim.api.nvim_set_hl(0, "@variable", { fg = "#D3C6AA" })
vim.api.nvim_set_hl(0, "@constant", { fg = "#DBBC7F" })
vim.api.nvim_set_hl(0, "@number", { fg = "#D699B6" })
vim.api.nvim_set_hl(0, "@boolean", { fg = "#7FBBB3" })
vim.api.nvim_set_hl(0, "@operator", { fg = "#D3C6AA" })
vim.api.nvim_set_hl(0, "@punctuation", { fg = "#5C6A72" })
vim.api.nvim_set_hl(0, "@tag", { fg = "#7FBBB3" })
vim.api.nvim_set_hl(0, "@tag.delimiter", { fg = "#475258" })
vim.api.nvim_set_hl(0, "@attribute", { fg = "#DBBC7F" })
vim.api.nvim_set_hl(0, "@property", { fg = "#D3C6AA" })
vim.api.nvim_set_hl(0, "@parameter", { fg = "#D3C6AA" })
vim.api.nvim_set_hl(0, "@field", { fg = "#D3C6AA" })
vim.api.nvim_set_hl(0, "@constructor", { fg = "#83C092" })
vim.api.nvim_set_hl(0, "@module", { fg = "#7FBBB3" })
vim.api.nvim_set_hl(0, "@namespace", { fg = "#7FBBB3" })
vim.api.nvim_set_hl(0, "@class", { fg = "#7FBBB3" })
vim.api.nvim_set_hl(0, "@struct", { fg = "#7FBBB3" })
vim.api.nvim_set_hl(0, "@interface", { fg = "#7FBBB3" })
vim.api.nvim_set_hl(0, "@enum", { fg = "#7FBBB3" })
vim.api.nvim_set_hl(0, "@enumMember", { fg = "#D699B6" })
vim.api.nvim_set_hl(0, "@event", { fg = "#83C092" })
vim.api.nvim_set_hl(0, "@decorator", { fg = "#DBBC7F" })
vim.api.nvim_set_hl(0, "@macro", { fg = "#D699B6" })
vim.api.nvim_set_hl(0, "@exception", { fg = "#E67E80" })
vim.api.nvim_set_hl(0, "@conditional", { fg = "#7FBBB3" })
vim.api.nvim_set_hl(0, "@repeat", { fg = "#7FBBB3" })
vim.api.nvim_set_hl(0, "@label", { fg = "#7FBBB3" })
vim.api.nvim_set_hl(0, "@include", { fg = "#7FBBB3" })
vim.api.nvim_set_hl(0, "@preproc", { fg = "#DBBC7F" })
vim.api.nvim_set_hl(0, "@define", { fg = "#DBBC7F" })
vim.api.nvim_set_hl(0, "@storageclass", { fg = "#7FBBB3" })
vim.api.nvim_set_hl(0, "@type.qualifier", { fg = "#7FBBB3" })
vim.api.nvim_set_hl(0, "@character", { fg = "#A7C080" })
vim.api.nvim_set_hl(0, "@escape", { fg = "#DBBC7F" })
vim.api.nvim_set_hl(0, "@regexp", { fg = "#DBBC7F" })
vim.api.nvim_set_hl(0, "@symbol", { fg = "#D3C6AA" })
vim.api.nvim_set_hl(0, "@text", { fg = "#D3C6AA" })
vim.api.nvim_set_hl(0, "@text.strong", { fg = "#D3C6AA", bold = true })
vim.api.nvim_set_hl(0, "@text.emphasis", { fg = "#D3C6AA", italic = true })
vim.api.nvim_set_hl(0, "@text.underline", { fg = "#D3C6AA", underline = true })
vim.api.nvim_set_hl(0, "@text.strike", { fg = "#D3C6AA", strikethrough = true })
vim.api.nvim_set_hl(0, "@text.literal", { fg = "#A7C080" })
vim.api.nvim_set_hl(0, "@text.reference", { fg = "#83C092" })
vim.api.nvim_set_hl(0, "@text.uri", { fg = "#83C092" })
vim.api.nvim_set_hl(0, "@text.math", { fg = "#D699B6" })
vim.api.nvim_set_hl(0, "@text.environment", { fg = "#7FBBB3" })
vim.api.nvim_set_hl(0, "@text.environment.name", { fg = "#83C092" })
vim.api.nvim_set_hl(0, "@text.note", { fg = "#5C6A72" })
vim.api.nvim_set_hl(0, "@text.warning", { fg = "#DBBC7F" })
vim.api.nvim_set_hl(0, "@text.danger", { fg = "#E67E80" })
vim.api.nvim_set_hl(0, "@text.todo", { fg = "#DBBC7F" })

-- Fallback Vim syntax highlighting
vim.api.nvim_set_hl(0, "Comment", { fg = "#5C6A72", italic = true })
vim.api.nvim_set_hl(0, "String", { fg = "#A7C080" })
vim.api.nvim_set_hl(0, "Keyword", { fg = "#7FBBB3", bold = true })
vim.api.nvim_set_hl(0, "Function", { fg = "#83C092" })
vim.api.nvim_set_hl(0, "Type", { fg = "#7FBBB3" })
vim.api.nvim_set_hl(0, "Identifier", { fg = "#D3C6AA" })

-- UI elements
vim.api.nvim_set_hl(0, "Cursor", { fg = "#2D353B", bg = "#D3C6AA" })
vim.api.nvim_set_hl(0, "Visual", { bg = "#5C6A72" })
vim.api.nvim_set_hl(0, "LineNr", { fg = "#5C6A72" })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#D3C6AA" })
vim.api.nvim_set_hl(0, "StatusLine", { bg = "#475258", fg = "#D3C6AA" })
vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "#5C6A72", fg = "#D3C6AA" })
vim.api.nvim_set_hl(0, "CursorLine", { bg = "#475258" })
vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#475258" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = "#5C6A72" })

-- NeoTree highlights
vim.api.nvim_set_hl(0, "NeoTreeDirectoryIcon", { fg = "#7FBBB3" })
vim.api.nvim_set_hl(0, "NeoTreeFileIcon", { fg = "#D3C6AA" })
vim.api.nvim_set_hl(0, "NeoTreeRootName", { fg = "#83C092" })
vim.api.nvim_set_hl(0, "NeoTreeDirectoryName", { fg = "#7FBBB3" })
vim.api.nvim_set_hl(0, "NeoTreeFileName", { fg = "#D3C6AA" })
vim.api.nvim_set_hl(0, "NeoTreeIndentMarker", { fg = "#5C6A72" })
vim.api.nvim_set_hl(0, "NeoTreeSymlink", { fg = "#83C092" })
vim.api.nvim_set_hl(0, "NeoTreeExecFile", { fg = "#A7C080" })