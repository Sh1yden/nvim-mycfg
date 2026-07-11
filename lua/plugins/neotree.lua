return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- Иконки файлов
      "MunifTanjim/nui.nvim",
    },
    config = function()
      local neotree = require("neo-tree")

      neotree.setup({
        close_if_last_window = true, -- Закрывать Neovim, если на экране остался только проводник
        filesystem = {
          filtered_items = {
            visible = true, -- Показывать скрытые файлы (например, .gitignore, файлы настроек)
            show_hidden_count = true,
          },
          follow_current_file = {
            enabled = true, -- Автоматически подсвечивать открытый файл в дереве проводника
          },
          use_libuv_file_watcher = true, -- Следить за изменениями файлов на диске в реальном времени
        },
        window = {
          width = 40, -- Ширина боковой панели
          mappings = {
            -- Встроенные горячие клавиши внутри панели проводника:
            -- "a" - Создать файл (если имя заканчивается на "/", создастся папка. Это заменяет и "a", и "shift+a"!)
            -- "d" - Удалить файл/папку
            -- "r" - Переименовать
            -- "c" - Скопировать (Copy)
            -- "x" - Вырезать (Cut)
            -- "p" - Вставить (Paste)
          }
        }
      })
    end,
  }
}
