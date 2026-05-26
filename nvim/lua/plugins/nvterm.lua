return {
  {
    "NvChad/nvterm",
    config = function()
      require("nvterm").setup({
        terminals = {
          shell = vim.o.shell,
          type_opts = {
            horizontal = { location = "belowright", split_ratio = 0.25 },
          },
        },
      })
      local nvterm = require("nvterm.terminal")
      vim.keymap.set({ "n", "t" }, "<A-t>", function()
        nvterm.toggle("horizontal")
      end, { desc = "Toggle horizontal terminal (NvTerm)" })
    end,
  },
}
