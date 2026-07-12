return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main", 
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup()

      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "python", "c", "cpp", "arduino", "javascript", "html", "css", "lua" },
        callback = function()
          -- pcall страхует нас от ошибок, если парсер для какого-то файла не установлен
          pcall(vim.treesitter.start)
        end,
      })

    end,
  }
}
