return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        -- Свой ghost-text и panel выключаем — подсказки идут через nvim-cmp
        -- (copilot-cmp ниже), чтобы не было двух разных UI одновременно.
        suggestion = { enabled = false },
        panel = { enabled = false },
        filetypes = {
          markdown = true,
          gitcommit = true,
        },
      })
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    dependencies = { "zbirenbaum/copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end,
  },
}
