return {
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "LspAttach",
    config = function()
      require("tiny-inline-diagnostic").setup({
        preset = "modern",
        options = {
          show_source = true,
        },
      })
      -- Свой рендер диагностик заменяет стандартный virtual_text от Neovim,
      -- иначе будет дублирование одной и той же ошибки дважды
      vim.diagnostic.config({ virtual_text = false })
    end,
  },
}
