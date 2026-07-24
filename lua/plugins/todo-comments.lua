return {
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
    keys = {
      { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "TODO/FIXME в Trouble" },
      { "<leader>ft", "<cmd>TodoFzfLua<cr>", desc = "TODO/FIXME через fzf-lua" },
      { "]t", function() require("todo-comments").jump_next() end, desc = "След. TODO" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Пред. TODO" },
    },
  },
}
