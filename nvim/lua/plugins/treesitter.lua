return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      ensure_installed = {
        "lua", "vim", "bash", "python", "javascript", "html", "css", "c", "cpp", "java", "typescript", "rust", "sql", "go", "xml", "yaml", "zig", "tsx", "tsv", "toml", "ssh_config", "scss", "ruby", "powershell", "php", "passwd", "markdown", "markdown_inline", "json", "json5", "jsonc", "ini", "hyprlang", "http", "htmldjango", "git_config", "git_rebase", "gitcommit", "gitignore", "fish", "desktop", "csv", "c_sharp", "angular"
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true,
      },
    },
     config = function(_, opts)
       require("nvim-treesitter.configs").setup(opts)
     end
  }
}

