return {
  {
    "mistweaverco/kulala.nvim",
    ft = { "http", "rest" },
    opts = {
      display_mode = "split", -- ответ в сплите справа
    },
    keys = {
      { "<leader>rr", function() require("kulala").run() end, desc = "REST: выполнить запрос" },
      { "<leader>rp", function() require("kulala").jump_prev() end, desc = "REST: пред. запрос" },
      { "<leader>rn", function() require("kulala").jump_next() end, desc = "REST: след. запрос" },
      { "<leader>rb", function() require("kulala").open() end, desc = "REST: открыть последний ответ" },
    },
  },
}
