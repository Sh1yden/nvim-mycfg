return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main", 
    build = ":TSUpdate",
    config = function()
      local ts = require("nvim-treesitter")

      ts.setup({
        ensure_installed = {
          "python", "c", "cpp", "arduino", "javascript",
          "typescript", "html", "css", "lua", "yaml",
          "toml", "dockerfile", "markdown", "markdown_inline",
          "json", "go", "sql", "bash",
        },
        auto_install = true,
        highlight = { enable = false },
        indent = { enable = false },
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "python", "c", "cpp", "arduino", "javascript",
          "typescript", "html", "css", "lua", "yaml",
          "toml", "dockerfile", "markdown", "json", "go",
          "sql", "bash",
        },
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })
    end,
  }
}
