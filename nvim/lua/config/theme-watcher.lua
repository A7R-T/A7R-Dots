-- Theme watcher for Neovim
-- Watch for theme changes and reload colors automatically

local theme_file = vim.fn.expand('~/.config/rofi/current-theme')

-- Function to reload colors
local function reload_colors()
    local colors_file = vim.fn.expand('~/.config/nvim/lua/config/colors.lua')
    if vim.fn.filereadable(colors_file) == 1 then
        -- Clear existing highlights
        vim.cmd('highlight clear')
        
        -- Reload the colors file
        dofile(colors_file)
        
        -- Notify user
        vim.notify('Theme reloaded!', vim.log.levels.INFO, { title = 'Theme Switcher' })
    end
end

-- Create autocmd to watch theme file
vim.api.nvim_create_autocmd({'BufWritePost', 'FileChangedShellPost'}, {
    pattern = theme_file,
    callback = reload_colors,
    desc = 'Reload Neovim theme when theme file changes'
})

-- Function to manually reload colors (can be called from theme switcher)
_G.reload_theme = reload_colors

-- Set up a user command for manual reloading
vim.api.nvim_create_user_command('ReloadTheme', reload_colors, { 
    desc = 'Reload the current Neovim theme' 
})