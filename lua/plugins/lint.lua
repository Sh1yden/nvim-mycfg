return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        dockerfile = { "hadolint" },
        sh = { "shellcheck" },
        bash = { "shellcheck" },
        -- python не добавляю: ruff уже даёт и линт, и формат через LSP,
        -- дублировать через nvim-lint смысла нет
      }

      local lint_augroup = vim.api.nvim_create_augroup("LintDebounce", { clear = true })
      local lint_timer = nil
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          if lint_timer then
            vim.fn.timer_stop(lint_timer)
          end
          lint_timer = vim.fn.timer_start(300, function()
            lint_timer = nil
            pcall(lint.try_lint)
          end)
        end,
      })
    end,
  },
}
