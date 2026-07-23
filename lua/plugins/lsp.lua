return {
    {
        "williamboman/mason.nvim",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            require("mason").setup()

            local servers = {
                "pyright",
                "ruff",
                "dockerls",
                "docker_compose_language_service",
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

            require("mason-lspconfig").setup({
                ensure_installed = servers,
                automatic_enable = true,
            })

            vim.lsp.config("*", {
                capabilities = require("cmp_nvim_lsp").default_capabilities(),
            })

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
                        schemas = {
                            ["https://json.schemastore.org/github-workflow.json"] = ".github/workflows/*.{yml,yaml}",
                            ["https://json.schemastore.org/docker-compose.json"] = "docker-compose*.{yml,yaml}",
                        },
                    },
                },
            })
        end,
    }
}
