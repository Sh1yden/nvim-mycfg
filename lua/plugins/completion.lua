return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",     -- Источник: подсказки от умного LSP
      "hrsh7th/cmp-buffer",       -- Источник: простые слова из открытого файла
      "hrsh7th/cmp-path",         -- Источник: пути к файлам и папкам
      "L3MON4D3/LuaSnip",         -- Движок сниппетов (шаблонов кода)
      "saadparwaiz1/cmp_luasnip", -- Связующее звено между сниппетами и cmp
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        -- Интеграция со сниппетами (без нее nvim-cmp выдаст ошибку при запуске)
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },

        -- Настройка горячих клавиш внутри всплывающего окна подсказок
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.select_prev_item(), -- Перемещение вверх по списку (Ctrl + k)
          ["<C-j>"] = cmp.mapping.select_next_item(), -- Перемещение вниз по списку (Ctrl + j)
          ["<C-e>"] = cmp.mapping.close(),            -- Закрыть окно подсказок (Ctrl + e)
          ["<C-Space>"] = cmp.mapping.complete(),     -- Принудительно вызвать меню (Ctrl + Space)
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Подтвердить выбор (Enter)
        }),

        -- Приоритет источников подсказок (какие показывать выше в списке)
        sources = cmp.config.sources({
          { name = "nvim_lsp" }, -- 1. Подсказки от умного LSP (типы, методы, переменные)
          { name = "luasnip" },  -- 2. Шаблоны кода (Сниппеты)
          { name = "path" },     -- 3. Пути к файлам/папкам
          { name = "buffer" },   -- 4. Просто слова из открытого файла
        }),
      })
    end,
  }
}
