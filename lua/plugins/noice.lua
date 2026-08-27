return {
  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      -- notify.enabled=false — Noice не перехватывает vim.notify() сам,
      -- этим занимается один-единственный require("notify").setup() ниже.
      -- Раньше оба лезли в vim.notify одновременно — отсюда была ошибка
      -- "vim.notify has been overwritten by another plugin".
      require("noice").setup({
        cmdline = {
          enabled = true,
          view = "cmdline_popup",
          opts = { border = "rounded" },
        },
        messages = { enabled = true, view = "notify" },
        popupmenu = { enabled = true, backend = "nui" },
        notify = { enabled = false },
        lsp = {
          progress = { enabled = true },
          hover = { enabled = true },
          signature = { enabled = true },
        },
        presets = {
          bottom_search = true,
          command_palette = true,
          long_message_to_split = true,
          inc_rename = true,
          lsp_doc_border = true,
        },
        routes = {
          { filter = { event = "lsp", kind = "progress", find = "pyright" }, opts = { skip = true } },

          -- Бесполезный информационный шум от стандартных команд vim —
          -- реально полезной информации в них нет
          { filter = { event = "msg_show", kind = "", find = "written" }, opts = { skip = true } },
          { filter = { event = "msg_show", kind = "", find = "yanked" }, opts = { skip = true } },
          { filter = { event = "msg_show", kind = "", find = "fewer lines" }, opts = { skip = true } },
          { filter = { event = "msg_show", kind = "", find = "more lines" }, opts = { skip = true } },
          { filter = { event = "msg_show", kind = "", find = "changes; before" }, opts = { skip = true } },
          { filter = { event = "msg_show", kind = "", find = "changes; after" }, opts = { skip = true } },
          { filter = { event = "msg_show", kind = "search_count" }, opts = { skip = true } },

          { filter = { event = "notify", find = "No results" }, opts = { skip = true } },
        },
      })

      require("notify").setup({
        background_colour = "#000000",
        timeout = 60 * 60 * 1000, -- час; закрывается вручную через <leader>un (баг notify c timeout=false, см. историю)
        stages = "static",
        render = "default",
        max_width = 80,
        minimum_width = 50,
      })

      vim.keymap.set("n", "<leader>un", function()
        require("notify").dismiss({ silent = true, pending = true })
      end, { desc = "Dismiss all notifications" })
    end,
  },
}
