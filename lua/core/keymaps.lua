local keymap = vim.keymap

-- Clear search highlight
keymap.set("n", "<leader>nh", ":nohlsearch<CR>", { desc = "Clear search highlight" })

-- Buffers
keymap.set("n", "<C-Tab>", ":bnext<CR>", { silent = true, desc = "Next buffer" })
keymap.set("n", "<C-S-Tab>", ":bprevious<CR>", { silent = true, desc = "Previous buffer" })
keymap.set("n", "<leader>nf", ":enew<CR>", { silent = true, desc = "New file" })
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
end, { silent = true, desc = "Close buffer" })

-- Explorer toggle
keymap.set("n", "<leader>b", ":Neotree toggle<CR>", { silent = true, desc = "Toggle file tree" })

-- Focus cycle: file -> neo-tree -> terminal -> file (только фокус, не открывает окна)
keymap.set("n", "<leader>f", function()
    local wins = vim.api.nvim_tabpage_list_wins(0)
    local neo_win, term_win, file_win
    local cur_win = vim.api.nvim_get_current_win()
    local cur_buf = vim.api.nvim_win_get_buf(cur_win)
    local cur_ft = vim.bo[cur_buf].filetype
    local cur_bt = vim.bo[cur_buf].buftype
    local cur_is_term = cur_bt == "terminal" or cur_ft == "toggleterm"
    local cur_is_neo = cur_ft == "neo-tree"

    for _, win in ipairs(wins) do
        local buf = vim.api.nvim_win_get_buf(win)
        local ft = vim.bo[buf].filetype
        local bt = vim.bo[buf].buftype
        if ft == "neo-tree" then
            neo_win = win
        elseif bt == "terminal" or ft == "toggleterm" then
            if not term_win then
                term_win = win
            end
        elseif not file_win and bt == "" then
            -- первый нормальный файловый буфер
            file_win = win
        end
    end
    -- fallback: если file_win не найден, ищем любой не-neo не-terminal
    if not file_win then
        for _, win in ipairs(wins) do
            if win ~= neo_win and win ~= term_win then
                file_win = win
                break
            end
        end
    end

    if cur_is_neo then
        if term_win then
            vim.api.nvim_set_current_win(term_win)
        elseif file_win then
            vim.api.nvim_set_current_win(file_win)
        end
    elseif cur_is_term then
        if file_win then
            vim.api.nvim_set_current_win(file_win)
        elseif neo_win then
            vim.api.nvim_set_current_win(neo_win)
        end
    else -- файл
        if neo_win then
            vim.api.nvim_set_current_win(neo_win)
        elseif term_win then
            vim.api.nvim_set_current_win(term_win)
        end
    end
end, { silent = true, desc = "Cycle focus file -> explorer -> terminal" })

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

-- Fzf search
keymap.set("n", "<leader>ff", "<cmd>FzfLua files<CR>", { silent = true, desc = "Find files" })
keymap.set("n", "<leader>fg", "<cmd>FzfLua live_grep<CR>", { silent = true, desc = "Grep project" })
keymap.set("n", "<leader>fb", "<cmd>FzfLua buffers<CR>", { silent = true, desc = "Find buffers" })

-- NeoVide (Windows GUI)
if vim.g.neovide then
    vim.keymap.set("v", "<C-c>", '"+y', { silent = true, desc = "Copy" })
    vim.keymap.set({ "n", "v" }, "<C-v>", '"+p', { silent = true, desc = "Paste" })
    vim.keymap.set({ "i", "c" }, "<C-v>", '<C-r>+', { silent = true, desc = "Paste" })
    vim.keymap.set("n", "<C-q>", "<C-v>", { silent = true, desc = "Visual block mode" })
end

-- Trouble diagnostics
keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", { silent = true, desc = "Project diagnostics" })
keymap.set("n", "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>",
    { silent = true, desc = "Buffer diagnostics" })

-- Git
keymap.set("n", "<leader>g", "<cmd>LazyGit<CR>", { silent = true, desc = "Open LazyGit" })
