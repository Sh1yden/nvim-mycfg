return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
      "b0o/schemastore.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
      require("mason").setup()

      -- Список серверов для mason-lspconfig (имена lspconfig, не mason-пакетов)
      local servers = {
        "pyright",                          -- Python (типы)
        "ruff",                             -- Python (линт/формат)
        "dockerls",                         -- Dockerfile
        "docker_compose_language_service",  -- docker-compose.yml (было с дефисами — неверно)
        "clangd",                           -- C++ / C
        "arduino_language_server",          -- Arduino
        "lua_ls",                           -- Lua
        "html",
        "cssls",
        "ts_ls",
        "gopls",
        "yamlls",
        "taplo",                            -- TOML (pyproject.toml)
        "marksman",                         -- Markdown
        "jsonls",
      }
      -- "dockerfmt" убран отсюда: это форматтер, а не LSP-сервер,
      -- mason-lspconfig не может его ставить через ensure_installed.
      -- Форматирование Dockerfile теперь настроено в conform.lua.

      -- ВАЖНО: в установленной версии mason-lspconfig.nvim (проверено по
      -- исходникам, lua/mason-lspconfig/settings.lua) поддерживаются ТОЛЬКО
      -- ensure_installed и automatic_enable. Опций automatic_installation
      -- и handlers в этой версии не существует — раньше они молча
      -- игнорировались (vim.tbl_deep_extend просто сливал незнакомые поля),
      -- поэтому capabilities и кастомные settings для gopls/yamlls никогда
      -- реально не применялись, хотя ошибок никто не видел.
      require("mason-lspconfig").setup({
        ensure_installed = servers,
        automatic_enable = true,
      })

      -- Линтеры (nvim-lint) и форматтеры (conform.lua), которые ставятся
      -- не как LSP-серверы, а как отдельные CLI-инструменты через mason
      require("mason-tool-installer").setup({
        ensure_installed = {
          "hadolint",     -- линтер Dockerfile (lint.lua)
          "shellcheck",   -- линтер bash/sh (lint.lua)
          "stylua",       -- форматтер Lua
          "prettierd",    -- форматтер JS/TS/HTML/CSS
          "fixjson",      -- форматтер JSON
        },
      })

      -- Пробрасываем capabilities от nvim-cmp во все LSP-серверы разом —
      -- актуальный способ через нативный vim.lsp.config (Neovim 0.11+).
      vim.lsp.config("*", {
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      })

      -- Кастомные настройки конкретных серверов задаются так же —
      -- через vim.lsp.config(имя_сервера, {...}), а не через handlers.
      vim.lsp.config("gopls", {
        settings = {
          gopls = {
            gofumpt = true,
            staticcheck = true,
            analyses = {
              unusedparams = true,
              shadow = true,
            },
          },
        },
      })

      vim.lsp.config("yamlls", {
        settings = {
          yaml = {
            -- schemastore.nvim знает схемы для docker-compose, GitHub Actions,
            -- сотен других форматов — вручную прописывать не нужно
            schemas = require("schemastore").yaml.schemas(),
          },
        },
      })

      vim.lsp.config("jsonls", {
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
          },
        },
      })
    end,
  },
}
