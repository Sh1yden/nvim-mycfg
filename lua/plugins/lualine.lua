return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- кэш LSP клиентов на LspAttach/Detach чтобы не дергать get_clients каждый рендер lualine
      local lsp_cache = ""
      local function update_lsp_cache()
        local clients = {}
        for _, c in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
          table.insert(clients, c.name)
        end
        lsp_cache = #clients == 0 and "" or "  " .. table.concat(clients, ", ")
      end
      vim.api.nvim_create_autocmd({ "LspAttach", "LspDetach" }, {
        group = vim.api.nvim_create_augroup("LualineLspCache", { clear = true }),
        callback = update_lsp_cache,
      })
      local function lsp_clients()
        return lsp_cache
      end

      local function dap_status()
        local ok, dap = pcall(require, "dap")
        if not ok then
          return ""
        end
        -- dap.status дорогой, вызываем только в сессии отладки
        if not dap.session() then
          return ""
        end
        local status = dap.status()
        if status == "" then
          return ""
        end
        return "  " .. status
      end

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
            { "branch", icon = "" },
            { "diff" },
          },
          lualine_c = {
            { "filename", path = 1 },
            { "searchcount", maxcount = 999 },
          },
          lualine_x = {
            { dap_status, color = { fg = "#e46876" } }, -- красным, чтобы бросалось в глаза при отладке
            { "diagnostics", sources = { "nvim_lsp" } },
            { lsp_clients, icon = "" },
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
