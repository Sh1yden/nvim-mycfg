return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "kanagawa",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          globalstatus = true,
        },
        sections = {
          lualine_a = {
            { "mode", separator = { left = "" }, right_padding = 2 },
          },
          lualine_b = {
            { "branch", icon = " " },
            { "diff" },
          },
          lualine_c = {
            { "filename", path = 1 },
          },
          lualine_x = {
            { "diagnostics", sources = { "nvim_lsp" } },
            { "filetype", icon_only = true },
          },
          lualine_y = { "progress" },
          lualine_z = {
            { "location", separator = { right = "" }, left_padding = 2 },
          },
        },
        inactive_sections = {
          lualine_c = { { "filename", path = 1 } },
        },
      })
    end,
  },
}
