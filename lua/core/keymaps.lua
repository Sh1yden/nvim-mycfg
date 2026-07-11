local keymap = vim.keymap

-- Clear Ligth Seacrh <Space> + n + h
keymap.set("n", "<leader>nh", ":nohlsearch<CR>", { desc = "Очистить подсветку поиска" })

-- Tabs
keymap.set("n", "<C-Tab>", ":bnext<CR>", { silent = true, desc = "Следующий файл" })
keymap.set("n", "<C-S-Tab>", ":bprevious<CR>", { silent = true, desc = "Предыдущий файл" })
keymap.set("n", "<leader>nf", ":enew<CR>", { silent = true, desc = "Новый пустой файл" })
keymap.set("n", "<leader>w", function()
  local current_buf = vim.api.nvim_get_current_buf()
  local bufs = vim.fn.getbufinfo({ buflisted = 1 })
  if #bufs <= 1 then
    vim.cmd("enew")
    vim.cmd("bd " .. current_buf)
  else
    vim.cmd("bprevious")
    vim.cmd("bd " .. current_buf)
  end
end, { silent = true, desc = "Закрыть файл" })

-- Explorer
keymap.set("n", "<leader>b", ":Neotree toggle<CR>", { silent = true, desc = "Проводник файлов" })

-- Focus Change
keymap.set("n", "<leader>f", function()
  local current_win = vim.api.nvim_get_current_win()
  local current_buf = vim.api.nvim_win_get_buf(current_win)
  local ft = vim.bo[current_buf].filetype -- Получаем тип текущего файла

  if ft == "neo-tree" then
    -- Если мы внутри проводника — возвращаемся в предыдущее окно с кодом
    vim.cmd("wincmd p")
  else
    -- Если мы в коде — ищем, открыт ли проводник на экране
    local found = false
    for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
      local buf = vim.api.nvim_win_get_buf(win)
      if vim.bo[buf].filetype == "neo-tree" then
        vim.api.nvim_set_current_win(win) -- Фокусируемся на найденном проводнике
        found = true
        break
      end
    end
    -- Если проводник вообще закрыт — открываем его и фокусируемся
    if not found then
      vim.cmd("Neotree focus")
    end
  end
end, { silent = true, desc = "Переключить фокус в проводник" })

-- Editor
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    local opts = { buffer = ev.buf, silent = true }

    -- gd = Go to Definition 
    keymap.set("n", "gd", vim.lsp.buf.definition, opts)

    -- K = Show Docs/Types
    keymap.set("n", "K", vim.lsp.buf.hover, opts)

    -- <leader> + r + n = Rename 
    keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

    -- Alt + Enter = Quick Fix
    keymap.set("n", "<M-CR>", vim.lsp.buf.code_action, opts)
  end,
})

-- fzf-Search
keymap.set("n", "<leader>ff", "<cmd>FzfLua files<CR>", { silent = true, desc = "Поиск файлов по названию" })
keymap.set("n", "<leader>fg", "<cmd>FzfLua live_grep<CR>", { silent = true, desc = "Поиск текста по всему проекту" })
keymap.set("n", "<leader>fb", "<cmd>FzfLua buffers<CR>", { silent = true, desc = "Поиск по открытым вкладкам" })

-- NeoVide
if vim.g.neovide then
  -- Копирование на Ctrl + C в визуальном режиме выделения
  vim.keymap.set("v", "<C-c>", '"+y', { silent = true, desc = "Копировать в Windows" })

  -- Вставка на Ctrl + V во всех режимах
  vim.keymap.set({"n", "v"}, "<C-v>", '"+p', { silent = true, desc = "Вставить из Windows" })
  vim.keymap.set({"i", "c"}, "<C-v>", '<C-r>+', { silent = true, desc = "Вставить из Windows" })

  -- Переносим режим "Визуального блока" (Visual Block) с Ctrl+V на Ctrl+Q
  vim.keymap.set("n", "<C-q>", "<C-v>", { silent = true, desc = "Режим вертикального столбца" })
end

