return {
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash: прыжок" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash: по treesitter-узлам" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Flash: remote-действие" },
    },
  },
}
