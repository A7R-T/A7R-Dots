return {
  {
  'glacambre/firenvim',
   build = ":call firenvim#install(0)",
    config = function()
    vim.g.firenvim_config = {
      globalSettings = {
        alt = "all",
      },
      localSettings = {
        [".*"] = {
          -- We target the Monaco editor class specifically
          selector = "div.monaco-editor",
          -- 'never' prevents the "instant flicker" by requiring manual trigger (Ctrl+e)
          priority = 1,
        },
      },
    }

    -- Auto-detect filetype for freeCodeCamp
    local fc_group = vim.api.nvim_create_augroup("FreeCodeCamp", { clear = true })
    vim.api.nvim_create_autocmd({ "BufEnter" }, {
      group = fc_group,
      pattern = "*freecodecamp.org*.txt",
      callback = function()
        -- Attempt to detect if it's HTML or JS based on URL/Content
        if vim.fn.search("<!DOCTYPE html>", "nw") ~= 0 then
          vim.bo.filetype = "html"
        else
          vim.bo.filetype = "javascript"
        end
      end,
    })
  end,
  }
}
