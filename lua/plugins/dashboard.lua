return {
  {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      dashboard.section.header.val = {
        "",
        "  ███╗   ██╗██╗   ██╗██╗███╗   ███╗",
        "  ████╗  ██║██║   ██║██║████╗ ████║",
        "  ██╔██╗ ██║╚██╗ ██╔╝██║██╔████╔██║",
        "  ██║╚██╗██║ ╚████╔╝ ██║██║╚██╔╝██║",
        "  ██║ ╚████║  ╚██╔╝  ██║██║ ╚═╝ ██║",
        "  ╚═╝  ╚═══╝   ╚═╝   ╚═╝╚═╝     ╚═╝",
        "",
      }

      dashboard.section.buttons.val = {
        dashboard.button("ff", "    Find file", "<cmd>FzfLua files<CR>"),
        dashboard.button("fg", "    Find text", "<cmd>FzfLua live_grep<CR>"),
        dashboard.button("fr", "    Recent files", "<cmd>FzfLua oldfiles<CR>"),
        dashboard.button("b",  "    File browser", "<cmd>Neotree toggle<CR>"),
        dashboard.button("q",  "    Quit", "<cmd>qa<CR>"),
      }

      dashboard.section.footer.val = {
        "",
        "    " .. vim.fn.strftime("%d.%m.%Y %H:%M"),
      }

      alpha.setup(dashboard.config)
    end,
  },
}
