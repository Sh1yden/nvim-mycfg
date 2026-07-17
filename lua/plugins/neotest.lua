return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/neotest-python",
      "nvim-neotest/neotest-jest",
      "nvim-neotest/neotest-go",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      local adapters = {}

      local ok_py, py = pcall(require, "neotest-python")
      if ok_py then
        table.insert(adapters, py({ dap = { justMyCode = false } }))
      end

      local ok_jest, jest = pcall(require, "neotest-jest")
      if ok_jest then
        table.insert(adapters, jest({ jestCommand = "npm test --", env = { CI = true } }))
      end

      local ok_go, go = pcall(require, "neotest-go")
      if ok_go then
        table.insert(adapters, go({ args = { "-count=1", "-timeout=60s" } }))
      end

      require("neotest").setup({
        adapters = adapters,
        status = { virtual_text = true },
        output = { open_on_run = true },
        quickfix = { enabled = true, open = false },
      })

      vim.keymap.set("n", "<leader>tr", function()
        require("neotest").run.run()
      end, { desc = "Nearest test" })
      vim.keymap.set("n", "<leader>ta", function()
        require("neotest").run.run(vim.fn.expand("%"))
      end, { desc = "All tests" })
      vim.keymap.set("n", "<leader>ts", function()
        require("neotest").run.stop()
      end, { desc = "Stop tests" })
      vim.keymap.set("n", "<leader>tt", function()
        require("neotest").summary.toggle()
      end, { desc = "Test summary" })
    end,
  },
}
