return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
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
          dockerfile = { "dockerfmt" },
          cs = { "csharpier" },
          c_sharp = { "csharpier" },
          ["_"] = { "trim_whitespace" },
        },
        format_on_save = {
          -- Актуальное имя опции — lsp_fallback переименован в lsp_format
          -- и принимает "prefer"/"fallback"/"never" (старое имя тихо
          -- игнорировалось, поэтому фолбэк на LSP реально не работал).
          lsp_format = "fallback",
          timeout_ms = 1000,
        },
        notify_on_error = true,
      })

      -- Патч csharpier empty output на WSL пути с пробелами "Test VS Code Projects"
      -- mason csharpier 1.2.6 требует --write-stdout при --stdin-path, иначе пустой stdout
      -- .gitignore не трогаем, другие проекты не трогаем
      pcall(function()
        require("conform").formatters.csharpier = {
          command = "csharpier",
          args = { "format", "--write-stdout", "--stdin-path", "$FILENAME" },
          stdin = true,
        }
      end)
    end,
  },
}
