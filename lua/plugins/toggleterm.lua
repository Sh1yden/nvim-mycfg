return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      local toggleterm = require("toggleterm")

      toggleterm.setup({
        size = 15,
        open_mapping = [[<C-Space>]],
        hide_numbers = true,
        shade_terminals = true,
        start_in_insert = true,
        insert_mappings = false, -- не перекрывать <C-Space> из nvim-cmp в insert-режиме
        terminal_mappings = true,
        direction = "horizontal",
        close_on_exit = true,
        shell = vim.o.shell,
      })

      function _G.set_terminal_keymaps()
        local opts = { buffer = 0 }
        vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
      end

      vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
    end,
  }
}
