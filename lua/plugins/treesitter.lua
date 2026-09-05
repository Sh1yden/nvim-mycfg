return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    config = function()
      -- main branch: setup больше не принимает ensure_installed/highlight/indent
      -- highlight теперь через vim.treesitter.start, indent через внутренний C indent (GetCSIndent)
      local ts = require("nvim-treesitter")

      -- установка парсеров - через :TSInstall, ensure_installed для совместимости оставляем
      -- но auto_install выключаем чтобы не тянуть gcc на каждый FileType
      pcall(function()
        ts.setup({
          ensure_installed = {
            "python", "c", "cpp", "arduino", "javascript",
            "typescript", "html", "css", "lua", "yaml",
            "toml", "dockerfile", "markdown", "markdown_inline",
            "json", "go", "sql", "bash", "c_sharp",
          },
        })
      end)

      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "python", "c", "cpp", "arduino", "javascript",
          "typescript", "html", "css", "lua", "yaml",
          "toml", "dockerfile", "markdown", "json", "go",
          "sql", "bash", "c_sharp", "cs",
        },
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })
    end,
  }
}
