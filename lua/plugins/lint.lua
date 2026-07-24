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

      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}
