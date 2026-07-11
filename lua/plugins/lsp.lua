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
        "pyright",     -- Python (анализ типов)
        "ruff",        -- Python (линтер и автоформаттер)
        "clangd",      -- C++ / C
        "arduino_language_server", -- Arduino 
        "lua_ls", -- Lua
        "html",        -- HTML
        "cssls",       -- CSS
        "ts_ls",       -- JavaScript / TypeScript
      }

      mason_lspconfig.setup({
        ensure_installed = servers,
        automatic_enable = true, 
      })
    end,
  }
}
