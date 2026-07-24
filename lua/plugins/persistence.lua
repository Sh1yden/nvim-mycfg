return {
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
    keys = {
      { "<leader>qs", function() require("persistence").load() end, desc = "Сессия: восстановить" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Сессия: последняя" },
      { "<leader>qd", function() require("persistence").stop() end, desc = "Сессия: не сохранять текущую" },
    },
  },
}
