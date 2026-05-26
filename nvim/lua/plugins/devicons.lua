return {
  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup({
        color_icons = false, -- This is the key for monochrome
        default = true,
      })
      -- Optional: override specific icons if they still leak color
    end,
  },
}