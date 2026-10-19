-- main-ветка nvim-treesitter: ensure_installed/highlight/indent из setup()
-- больше не существуют. Парсеры ставятся через ts.install(), хайлайт
-- включается вручную через vim.treesitter.start() на FileType.
local parsers = {
  "python", "c", "cpp", "arduino", "javascript",
  "typescript", "html", "css", "lua", "yaml",
  "toml", "dockerfile", "markdown", "markdown_inline",
  "json", "go", "sql", "bash", "c_sharp",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    -- main-ветка не поддерживает lazy-loading (см. README плагина)
    lazy = false,
    -- при обновлении плагина парсеры нужно пересобрать под новую ABI
    build = ":TSUpdate",
    config = function()
      local ts = require("nvim-treesitter")

      -- Базовый набор ставится в фоне при старте; для уже установленных
      -- парсеров это no-op (установка идемпотентна).
      ts.install(parsers)

      local available = ts.get_available()

      -- language.add возвращает nil/false, если парсера нет, а не ошибку,
      -- поэтому pcall-заглушка, которая раньше молча глотала ошибки,
      -- не нужна.
      local function attach(buf, lang)
        if not vim.api.nvim_buf_is_valid(buf) then
          return
        end
        if not vim.treesitter.language.add(lang) then
          return
        end
        vim.treesitter.start(buf, lang)
      end

      -- Хайлайт включается на FileType, как рекомендует README плагина.
      -- Если парсера ещё нет — докачиваем его и включаем подсветку после
      -- установки: перезапуск Neovim или :e не нужны.
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local buf, filetype = args.buf, args.match
          local lang = vim.treesitter.language.get_lang(filetype)
          if not lang then
            return
          end

          if vim.tbl_contains(ts.get_installed("parsers"), lang) then
            attach(buf, lang)
          elseif vim.tbl_contains(available, lang) then
            ts.install(lang):await(function()
              attach(buf, lang)
            end)
          else
            -- парсер не относится к nvim-treesitter (например, встроенный в Neovim)
            attach(buf, lang)
          end
        end,
      })
    end,
  },
}
