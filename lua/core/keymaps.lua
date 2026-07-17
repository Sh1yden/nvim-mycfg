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

-- Focus neo-tree / back to code
keymap.set("n", "<leader>f", function()
    local current_win = vim.api.nvim_get_current_win()
    local current_buf = vim.api.nvim_win_get_buf(current_win)
    local ft = vim.bo[current_buf].filetype

    if ft == "neo-tree" then
        vim.cmd("wincmd p")
    else
        local found = false
        for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
            local buf = vim.api.nvim_win_get_buf(win)
            if vim.bo[buf].filetype == "neo-tree" then
                vim.api.nvim_set_current_win(win)
                found = true
                break
            end
        end
        if not found then
            vim.cmd("Neotree focus")
        end
    end
end, { silent = true, desc = "Toggle focus explorer/code" })

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
