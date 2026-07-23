return {
  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup({
        cmdline = {
          enabled = true,
          view = "cmdline_popup",
          opts = { border = "rounded" },
        },
        messages = { enabled = true, view = "notify" },
        popupmenu = { enabled = true, backend = "nui" },
        notify = { enabled = true },
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
          {
            filter = { event = "lsp", kind = "progress", find = "pyright" },
            opts = { skip = true },
          },
          {
            filter = { event = "msg_show", kind = "", find = "written" },
            opts = { skip = true },
          },
          {
            filter = { event = "notify", find = "No results" },
            opts = { skip = true },
          },
        },
      })

      -- ВАЖНО: timeout = 0 в nvim-notify означает "скрыть через 0 мс",
      -- а не "никогда не скрывать" (для этого нужно timeout = false).
      -- С нулём уведомления исчезают почти мгновенно после появления —
      -- из-за этого казалось, что ошибки/варнинги вообще не показываются.
      require("notify").setup({
        background_colour = "#000000",
        -- timeout = false задумывался как "не скрывать вообще", но в
        -- установленной версии nvim-notify это КРАШИТ окно уведомления:
        -- в lua/notify/windows/init.lua используется идиома `a and b or c`,
        -- а поскольку b (наш default_timeout()) сам равен false, Lua
        -- проваливается в ветку c и передаёт nil туда, где ждёт число.
        -- Обходим встроенный баг большим числом — фактически то же самое
        -- "не скрывать за время сессии", но без краша.
        timeout = 60 * 60 * 1000, -- час; закрывается вручную через <leader>un
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
