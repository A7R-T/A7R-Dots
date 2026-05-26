return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({
        -- Basic config; add options if needed (e.g., disable for markdown)
      })
    end,
  },
}