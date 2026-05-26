return {
  {
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          python = { "black" },
          lua = { "stylua" },
          javascript = { "prettier" },
          typescript = { "prettier" },
          html = { "prettier" },
          css = { "prettier" },
          json = { "prettier" },
          markdown = { "prettier" },
          c = { "clang_format" },
          cpp = { "clang_format" },
          php = { "php_cs_fixer" },
          go = { "gofmt" },
          rust = { "rustfmt" },
          ruby = { "rubocop" },
          java = { "clang_format" },
        },
      })
    end,
  },
}