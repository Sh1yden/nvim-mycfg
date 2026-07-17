return {
  {
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          python = { "ruff_format" },
          javascript = { "prettierd", "prettier" },
          typescript = { "prettierd", "prettier" },
          javascriptreact = { "prettierd", "prettier" },
          typescriptreact = { "prettierd", "prettier" },
          json = { "fixjson" },
          html = { "prettierd", "prettier" },
          css = { "prettierd", "prettier" },
          c = { "clang_format" },
          cpp = { "clang_format" },
          arduino = { "clang_format" },
          go = { "gofumpt", "goimports" },
          yaml = { "yamlfmt" },
          toml = { "taplo" },
          markdown = { "markdownlint" },
          ["_"] = { "trim_whitespace" },
        },
        format_on_save = {
          lsp_fallback = true,
          timeout_ms = 1000,
        },
        notify_on_error = false,
      })
    end,
  },
}
