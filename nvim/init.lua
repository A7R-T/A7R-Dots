vim.opt.termguicolors = true
require("config.lazy")
require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.sync")
require("config.database")

vim.cmd("highlight Normal guibg=NONE ctermbg=NONE")
vim.cmd("highlight NormalNC guibg=NONE ctermbg=NONE")
vim.cmd("highlight SignColumn guibg=NONE ctermbg=NONE")
vim.cmd("highlight LineNr guibg=NONE ctermbg=NONE")
vim.cmd("highlight CursorLineNr guibg=NONE ctermbg=NONE")
vim.cmd("highlight EndOfBuffer guibg=NONE ctermbg=NONE")

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    require("config.colors")
    require("config.theme-watcher")
  end
})

if vim.g.started_by_firenvim == true then
    -- Make firenvim less picky / more patient on FCC
    vim.g.firenvim_config = vim.g.firenvim_config or { globalSettings = {}, localSettings = {} }
    local gs = vim.g.firenvim_config.globalSettings
    local ls = vim.g.firenvim_config.localSettings

    gs.ignore = { '.*' }  -- optional: ignore auto everywhere, force manual

    -- FCC-specific: never auto, but allow manual trigger
    ls["www.freecodecamp.org"] = {
        selector = 'div.monaco-editor, .monaco-mouse-cursor-text, [data-testid="monaco-editor"]',  -- more aggressive selectors
        priority = 100,  -- higher = wins over defaults
        takeover = 'always'   -- force it even if detection fails
    }

    -- Or ultra-force: disable auto-detection entirely and rely on manual <C-e>
    -- ls["www.freecodecamp.org"] = { takeover = 'never' }
end
