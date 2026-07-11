return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      local toggleterm = require("toggleterm")

      toggleterm.setup({
        size = 15, -- Высота окна терминала в строках
        open_mapping = [[<C-Space>]], -- Открывать и закрывать терминал по Ctrl + Space
        hide_numbers = true, -- Скрывать номера строк внутри терминала
        shade_terminals = true, -- Немного затенять фон терминала для визуального разделения
        start_in_insert = true, -- Сразу входить в режим ввода команд при открытии
        insert_mappings = true, -- Позволяет закрывать терминал по Ctrl+Space прямо в режиме ввода
        terminal_mappings = true, -- Позволяет закрывать терминал по Ctrl+Space в режиме терминала
        direction = "horizontal", -- Появляться снизу (как в классических IDE)
        close_on_exit = true, -- Автоматически закрывать окно Neovim, если в консоли написали exit
        shell = vim.o.shell, -- Использовать дефолтный шелл твоей системы Arch Linux
      })

      -- Архитектурная фича: Удобный выход из режима терминала
      -- По умолчанию в Neovim, чтобы выйти из ввода в терминале в Normal-режим,
      -- нужно нажать сложнейшее сочетание <C-\><C-n>. 
      -- Мы настроим обычный выход по клавише <Esc>.
      function _G.set_terminal_keymaps()
        local opts = { buffer = 0 }
        -- Нажатие Esc переведет терминал в Normal-режим Neovim
        vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts) 
      end

      -- Применять эти настройки горячих клавиш каждый раз при открытии любого терминала
      vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
    end,
  }
}
