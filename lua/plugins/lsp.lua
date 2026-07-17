return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig", 
    },
    config = function()
      local mason = require("mason")
      local mason_lspconfig = require("mason-lspconfig")

      mason.setup()

      local servers = {
        "pyright",
        "ruff",
        "clangd",
        "arduino_language_server",
        "lua_ls",
        "html",
        "cssls",
        "ts_ls",
        "gopls",
        "yamlls",
        "taplo",
        "marksman",
        "jsonls",
      }

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      mason_lspconfig.setup({
        ensure_installed = servers,
        automatic_installation = true,
        handlers = {
          function(server_name)
            pcall(function()
              local config = vim.lsp.config[server_name]
              if not config then
                return
              end

              config.capabilities = capabilities

              if server_name == "gopls" then
                config.settings = {
                  gopls = {
                    gofumpt = true,
                    staticcheck = true,
                    analyses = {
                      unusedparams = true,
                      shadow = true,
                    },
                  },
                }
              end

              if server_name == "yamlls" then
                config.settings = {
                  yaml = {
                    schemas = {
                      ["https://json.schemastore.org/github-workflow.json"] = ".github/workflows/*.{yml,yaml}",
                      ["https://json.schemastore.org/docker-compose.json"] = "docker-compose*.{yml,yaml}",
                    },
                  },
                }
              end

              vim.lsp.enable(server_name)
            end)
          end,
        },
      })
    end,
  }
}
