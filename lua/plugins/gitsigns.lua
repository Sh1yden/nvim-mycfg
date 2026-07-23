return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      current_line_blame = true,
      current_line_blame_opts = {
        delay = 300,
        virt_text_pos = "eol",
      },
      on_attach = function(bufnr)
        local gs = require("gitsigns")
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
        end

        map("n", "]h", gs.next_hunk, "Следующий hunk")
        map("n", "[h", gs.prev_hunk, "Предыдущий hunk")

        map("n", "<leader>hs", gs.stage_hunk, "Застейджить hunk")
        map("n", "<leader>hr", gs.reset_hunk, "Откатить hunk")
        map("v", "<leader>hs", function()
          gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, "Застейджить выделение")
        map("v", "<leader>hr", function()
          gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, "Откатить выделение")

        map("n", "<leader>hS", gs.stage_buffer, "Застейджить весь файл")
        map("n", "<leader>hR", gs.reset_buffer, "Откатить весь файл")
        map("n", "<leader>hp", gs.preview_hunk, "Предпросмотр hunk")
        map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, "Blame строки")
        map("n", "<leader>tb", gs.toggle_current_line_blame, "Вкл/выкл inline blame")
        map("n", "<leader>hd", gs.diffthis, "Diff с индексом")
      end,
    },
  },
}
