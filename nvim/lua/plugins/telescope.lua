return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-project.nvim',
      'nvim-telescope/telescope-file-browser.nvim',
    },
    config = function()
      local telescope = require('telescope')
      local actions = require('telescope.actions')
      
      telescope.setup({
        defaults = {
          -- Better file finding defaults
          file_ignore_patterns = {
            -- Git and version control
            '.git/',
            '.gitignore',
            '.gitmodules',
            
            -- Node.js dependencies and build artifacts
            'node_modules/',
            'dist/',
            'build/',
            'out/',
            '.next/',
            '.nuxt/',
            '.cache/',
            
            -- Python cache and virtual environments
            '__pycache__/',
            '*.pyc',
            '.pytest_cache/',
            '.venv/',
            'venv/',
            'env/',
            
            -- Rust build artifacts
            'target/',
            'Cargo.lock',
            
            -- Go modules
            'vendor/',
            
            -- IDE and editor files
            '.vscode/',
            '.idea/',
            '*.swp',
            '*.swo',
            '*~',
            '.DS_Store',
            'Thumbs.db',
            
            -- Log files
            '*.log',
            
            -- Temporary files
            '*.tmp',
            '*.temp',
            '*.bak',
            '*.old',
            '*.orig',
            
            -- Large binary files
            '*.exe',
            '*.dll',
            '*.so',
            '*.dylib',
            
            -- Archive files
            '*.zip',
            '*.tar',
            '*.tar.gz',
            '*.tgz',
            '*.rar',
            '*.7z',
          },
          
          -- Better sorting and display
          sorting_strategy = 'descending',
          layout_strategy = 'vertical',
          layout_config = {
            vertical = {
              width = 0.9,
              height = 0.9,
              preview_cutoff = 20,
            },
          },
          
          -- Better mappings
          mappings = {
            i = {
              ['<C-u>'] = false,
              ['<C-d>'] = false,
              ['<C-q>'] = actions.send_to_qflist + actions.open_qflist,
              ['<M-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
              ['<C-x>'] = actions.select_horizontal,
              ['<C-v>'] = actions.select_vertical,
              ['<C-t>'] = actions.select_tab,
              ['<CR>'] = actions.select_default + actions.center,
            },
            n = {
              ['q'] = actions.close,
              ['<C-q>'] = actions.send_to_qflist + actions.open_qflist,
              ['<M-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
              ['x'] = actions.select_horizontal,
              ['v'] = actions.select_vertical,
              ['t'] = actions.select_tab,
            },
          },
        },
        
        -- Enhanced pickers with better defaults
        pickers = {
          find_files = {
            -- Search in common directories
            find_command = {
              'fd',
              '--type', 'f',
              '--hidden',
              '--follow',
              '--exclude', '.git',
              '--exclude', 'node_modules',
              '--exclude', 'target',
              '--exclude', 'build',
              '--exclude', 'dist',
              '--exclude', '__pycache__',
              '--exclude', '.venv',
              '--exclude', 'venv',
              '--exclude', '.pytest_cache',
              '--max-depth', '4',
            },
          },
          
          live_grep = {
            -- Better grep options
            additional_args = function(opts)
              return {
                '--hidden',
                '--glob', '!{.git,node_modules,target,build,dist,__pycache__,.venv,venv}/*',
                '--exclude-dir', '.git',
                '--exclude-dir', 'node_modules',
                '--exclude-dir', 'target',
                '--exclude-dir', 'build',
                '--exclude-dir', 'dist',
                '--exclude-dir', '__pycache__',
                '--exclude-dir', '.venv',
                '--exclude-dir', 'venv',
              }
            end,
          },
          
          buffers = {
            -- Show only loaded buffers
            show_all_buffers = false,
            sort_lastused = true,
            theme = 'dropdown',
          },
          
          oldfiles = {
            -- Better recent files
            only_cwd = false,
            cwd_only = false,
            stat_file = true,
          },
        },
        
        -- Enhanced file browser
        extensions = {
          file_browser = {
            theme = 'ivy',
            hijack_netrw = true,
            hidden = true,
            respect_gitignore = true,
            files = true,
            grouped = true,
            depth = 2,
            select_buffer = true,
          },
          
          project = {
            base_dirs = {
              -- '~/Documents',
              '~/Downloads',
              -- '~/Projects',
              -- '~/workspace',
              -- '~/src',
              '~/.config',
              '~/A7R'
            },
            hidden_files = true,
          },
        },
      })
      
      -- Load extensions
      telescope.load_extension('project')
      telescope.load_extension('file_browser')
      
      -- Custom pickers for better file finding
      local pickers = require('telescope.pickers')
      local finders = require('telescope.finders')
      local conf = require('telescope.config').values
      local action_state = require('telescope.actions.state')
      
      -- Custom file finder focused on common directories with enhanced filtering
      local function find_files_smart(opts)
        opts = opts or {}
        local common_dirs = {
          '~/Documents',
          '~/Downloads', 
          '~/Pictures',
          '~/Videos',
          '~/Music',
          '~/Desktop',
          '~/.config',
          '~/Projects',
          '~/workspace',
          '~/src',
          '~/',
        }
        
        local fd_command = {'fd', '--type', 'f', '--hidden', '--follow', '--max-depth', '4'}
        
        -- Enhanced exclusions - more comprehensive filtering
        local exclusions = {
          -- Version control
          '.git', '.svn', '.hg', '.bzr',
          -- Dependencies and build artifacts
          'node_modules', '.npm', '.yarn', 'pnpm-store', 
          'target', 'build', 'dist', 'out', 'bin', '.next', '.nuxt', '.output',
          -- Python
          '__pycache__', '.pytest_cache', '.mypy_cache', '.tox', '.coverage', 'htmlcov',
          '.venv', 'venv', 'env', 'pip-cache', 'site-packages',
          -- Rust
          'Cargo.lock', 'debug', 'target',
          -- Go
          'vendor', '.cache',
          -- Java
          '.gradle', '.m2', 'target', 'build', 'out', 'classes',
          -- IDE/Editor
          '.vscode', '.idea', '.eclipse', '.vim', '.nvim',
          -- System
          '.DS_Store', 'Thumbs.db', 'desktop.ini', '.localized',
          -- Cache/Temp
          '.cache', 'tmp', 'temp', 'var', 'opt', 'usr', 'lib', 'etc',
          -- Logs and backups
          '*.log', '*.tmp', '*.temp', '*.bak', '*.old', '*.orig', '*.rej',
          '*.swp', '*.swo', '*~', '.#*', '#*#',
          -- Package manager files
          'package-lock.json', 'yarn.lock', 'pnpm-lock.yaml', 'poetry.lock',
          'Cargo.lock', 'go.sum', 'composer.lock',
          -- Large media files (can be overwhelming)
          '*.jpg', '*.jpeg', '*.png', '*.gif', '*.bmp', '*.svg', '*.webp',
          '*.mp4', '*.avi', '*.mkv', '*.webm', '*.mov', '*.flv', '*.wmv',
          '*.mp3', '*.flac', '*.wav', '*.ogg', '*.m4a', '*.aac', '*.wma',
          -- Archives
          '*.zip', '*.tar', '*.tar.gz', '*.tgz', '*.bz2', '*.xz', '*.7z', '*.rar',
          -- System binaries
          '*.exe', '*.dll', '*.so', '*.dylib', '*.app', '*.deb', '*.rpm',
        }
        
        for _, excl in ipairs(exclusions) do
          table.insert(fd_command, '--exclude')
          table.insert(fd_command, excl)
        end
        
        -- Add search directories that exist
        local search_dirs = {}
        for _, dir in ipairs(common_dirs) do
          if vim.fn.isdirectory(vim.fn.expand(dir)) == 1 then
            table.insert(search_dirs, vim.fn.expand(dir))
          end
        end
        
        -- Only add directories that exist
        if #search_dirs > 0 then
          for _, dir in ipairs(search_dirs) do
            table.insert(fd_command, dir)
          end
        else
          -- Fallback to current directory if no common dirs exist
          table.insert(fd_command, '.')
        end
        
        pickers.new(opts, {
          prompt_title = 'Smart Files (' .. #search_dirs .. ' dirs)',
          finder = finders.new_oneshot_job(fd_command, conf.get_picker_opts(opts)),
          sorter = conf.file_sorter(opts),
          previewer = conf.file_previewer(opts),
        }):find()
      end
      
      -- Keymaps for custom functions
      vim.keymap.set('n', '<leader>ff', find_files_smart, { desc = 'Find Files (Smart)' })
      vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { desc = 'Live Grep' })
      vim.keymap.set('n', '<leader>fe', '<cmd>Telescope file_browser<cr>', { desc = 'File Browser' })
      vim.keymap.set('n', '<leader>fp', '<cmd>Telescope project<cr>', { desc = 'Projects' })
      vim.keymap.set('n', '<leader>fr', '<cmd>Telescope oldfiles<cr>', { desc = 'Recent Files' })
      vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>', { desc = 'Buffers' })
      vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', { desc = 'Help Tags' })
      
    end,
  },
}
