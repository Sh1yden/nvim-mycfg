return {
  {
    "rest-nvim/rest.nvim",
    ft = { "http", "rest" },
    -- Без .setup(): конфигурация через vim.g.rest_nvim (дефолты подходят).
    -- Rock-зависимости (nvim-nio, mimetypes, xml2lua, fidget.nvim,
    -- tree-sitter-http) идут из rockspec и ставятся lazy+hererocks сами.
    -- НО: в дереве hererocks должен лежать build-бэкенд, иначе luarocks 3.13
    -- не находит его при сборке tree-sitter-http (одноразовый бутстрап):
    --   luarocks --tree ~/.local/share/nvim/lazy-rocks/hererocks \
    --     install luarocks-build-treesitter-parser
    -- Парсер http для подсветки ставится отдельно через nvim-treesitter
    -- (см. treesitter.lua) — как советует README rest.nvim для lazy.nvim.
    keys = {
      { "<leader>rr", "<cmd>Rest run<cr>", desc = "REST: выполнить запрос", ft = { "http", "rest" } },
      { "<leader>rl", "<cmd>Rest last<cr>", desc = "REST: повторить последний", ft = { "http", "rest" } },
      { "<leader>ro", "<cmd>Rest open<cr>", desc = "REST: открыть ответ", ft = { "http", "rest" } },
    },
  },
}
