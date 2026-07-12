return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl", -- Запуск современной версии v3
    config = function()
      local ibl = require("ibl")
      local hooks = require("ibl.hooks")

      -- Список названий наших радужных групп подсветки
      local highlight = {
        "IndentRainbowRed",
        "IndentRainbowYellow",
        "IndentRainbowBlue",
        "IndentRainbowOrange",
        "IndentRainbowGreen",
        "IndentRainbowViolet",
      }

      -- Воссоздаем цвета при каждом сбросе или смене темы
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "IndentRainbowRed", { fg = "#E46876" })
        vim.api.nvim_set_hl(0, "IndentRainbowYellow", { fg = "#E6C384" })
        vim.api.nvim_set_hl(0, "IndentRainbowBlue", { fg = "#7E9CD8" })
        vim.api.nvim_set_hl(0, "IndentRainbowOrange", { fg = "#FF9E3B" })
        vim.api.nvim_set_hl(0, "IndentRainbowGreen", { fg = "#98BB6C" })
        vim.api.nvim_set_hl(0, "IndentRainbowViolet", { fg = "#957FB8" })
      end)

      ibl.setup({
        indent = {
          char = "│", -- Красивая тонкая вертикальная линия отступа
          highlight = highlight,
        },
        scope = {
          enabled = true, -- Подсвечивать текущую область видимости (блок кода)
          char = "┃",     -- Сделать текущую линию более толстой
        },
        exclude = {
          filetypes = {
            "help",
            "alpha",
            "dashboard",
            "neo-tree",
            "Trouble",
            "trouble",
            "lazy",
            "mason",
            "notify",
            "toggleterm",
            "lazyterm",
            "checkhealth",
          },
          buftypes = {
            "terminal",
            "nofile",
            "quickfix",
            "prompt",
          },
        },
      })
    end
  }
}