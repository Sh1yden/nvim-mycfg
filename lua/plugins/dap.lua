return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
      "jay-babu/mason-nvim-dap.nvim",
      "mfussenegger/nvim-dap-python",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      pcall(function()
        require("mason-nvim-dap").setup({
          automatic_installation = true,
          ensure_installed = { "codelldb" },
        })
      end)

      pcall(require("nvim-dap-virtual-text").setup)

      dapui.setup({
        icons = { expanded = "▾", collapsed = "▸" },
        layouts = {
          {
            position = "right", size = 40,
            elements = {
              { id = "scopes",      size = 0.25 },
              { id = "breakpoints", size = 0.25 },
              { id = "stacks",      size = 0.25 },
              { id = "watches",     size = 0.25 },
            },
          },
          {
            position = "bottom", size = 10,
            elements = {
              { id = "repl",    size = 0.5 },
              { id = "console", size = 0.5 },
            },
          },
        },
      })

      require("dap-python").setup("python3")

      dap.listeners.after.event_initialized["dapui_config"] = dapui.open
      dap.listeners.before.event_terminated["dapui_config"] = dapui.close
      dap.listeners.before.event_exited["dapui_config"] = dapui.close

      vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "DAP Continue" })
      vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "DAP Step over" })
      vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "DAP Step into" })
      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "DAP Toggle breakpoint" })
      vim.keymap.set("n", "<leader>dB", function()
        dap.set_breakpoint(vim.fn.input("Condition: "))
      end, { desc = "DAP Conditional breakpoint" })
      vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "DAP Open REPL" })
      vim.keymap.set("n", "<leader>dd", dapui.toggle, { desc = "DAP Toggle UI" })
    end,
  },
  {
    "leoluz/nvim-dap-go",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      pcall(function() require("dap-go").setup() end)
    end,
  },
}
