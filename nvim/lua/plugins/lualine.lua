return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local p = {
        bg = "#192B3A",
        fg = "#8fb8d5",
        dark = "#192B3A",
        mid = "#3E6383",
        bright = "#6DA6CE",
      }

      local sovereign_theme = {
        normal = {
          a = { fg = p.dark, bg = p.bright, gui = 'bold' },
          b = { fg = p.fg, bg = p.mid },
          c = { fg = p.fg, bg = p.bg },
        },
        insert = {
          a = { fg = p.dark, bg = "#8fb8d5", gui = 'bold' },
          b = { fg = p.fg, bg = p.mid },
        },
        visual = {
          a = { fg = p.dark, bg = "#4C7B9D", gui = 'bold' },
          b = { fg = p.fg, bg = p.mid },
        },
        replace = {
          a = { fg = p.dark, bg = "#669BC1", gui = 'bold' },
          b = { fg = p.fg, bg = p.mid },
        },
        inactive = {
          a = { fg = p.mid, bg = p.dark, gui = 'bold' },
          b = { fg = p.mid, bg = p.dark },
          c = { fg = p.mid, bg = p.dark },
        },
      }

      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = sovereign_theme,
          component_separators = { left = '', right = ''},
          section_separators = { left = '', right = ''},
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          always_show_tabline = true,
          globalstatus = false,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
            refresh_time = 16, -- ~60fps
            events = {
              'WinEnter',
              'BufEnter',
              'BufWritePost',
              'SessionLoadPost',
              'FileChangedShellPost',
              'VimResized',
              'Filetype',
              'CursorMoved',
              'CursorMovedI',
              'ModeChanged',
            },
          }
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {
            'branch',
            {
              'diff',
              colored = true,
              diff_color = {
                added    = { fg = "#6DA6CE" },
                modified = { fg = "#6399C0" },
                removed  = { fg = "#3E6383" },
              },
            },
            {
              'diagnostics',
              sections = { 'error', 'warn', 'info', 'hint' },
              diagnostics_color = {
                error = { fg = "#3E6383" },
                warn  = { fg = "#507FA3" },
                info  = { fg = "#6399C0" },
                hint  = { fg = "#4C7B9D" },
              },
            },
          },
          lualine_c = {'filename'},
          lualine_x = {'encoding', 'fileformat', 'filetype'},
          lualine_y = {'progress'},
          lualine_z = {'location'}
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {'filename'},
          lualine_x = {'location'},
          lualine_y = {},
          lualine_z = {}
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {}
      }
    end,
  },
}
