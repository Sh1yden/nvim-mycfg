return {
  {
    "vyfor/cord.nvim",
    build = ":Cord update",
    event = "VeryLazy",
    config = function()
      require("cord").setup()
    end
  }
}
