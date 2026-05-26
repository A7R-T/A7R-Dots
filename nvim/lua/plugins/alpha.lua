return {
  {
    'goolord/alpha-nvim',
    config = function()
      local alpha = require('alpha')
      local dashboard = require('alpha.themes.dashboard')

      -- Load ASCII art from file
      local header_file = vim.fn.expand('~/Pictures/A7R.txt')
      local header_lines = {}
      local file = io.open(header_file, 'r')
      if file then
        for line in file:lines() do
          table.insert(header_lines, line)
        end
        file:close()
      else
        header_lines = { 'File not found: ' .. header_file }
      end

      dashboard.section.header.val = header_lines

      -- Keep default buttons
      alpha.setup(dashboard.config)
    end
  }
}
