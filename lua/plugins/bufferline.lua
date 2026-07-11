return {
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- Красивые иконки для разных типов файлов
    },
    config = function()
      local bufferline = require("bufferline")

      bufferline.setup({
        options = {
          mode = "buffers", -- Режим отображения файлов (VS Code стиль)
          always_show_bufferline = true,
          
          -- Интеграция с нашим LSP! 
          -- Если в файле есть ошибки, прямо на вкладке появится маленький значок предупреждения.
          diagnostics = "nvim_lsp", 
          
          -- Настройка отступа, если слева открыт проводник (чтобы вкладки не налезали на него)
          offsets = {
            {
              filetype = "neo-tree",
              text = "File Explorer",
              text_align = "left",
              separator = true,
            },
          },
        },
      })
    end,
  }
}
