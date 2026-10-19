return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup({
        plugins = {
          spelling = true,
          presets = { operators = false },
        },
        icons = {
          breadcrumb = "»",
          separator = "➜",
          group = "",
        },
        win = { border = "rounded", height = { min = 4, max = 25 } },
        layout = {
          width = { min = 20, max = 50 },
          spacing = 3,
        },
      })
    end,
  },
}
