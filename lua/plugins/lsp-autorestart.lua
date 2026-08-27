-- pyright не видит новые зависимости, пока его не перезапустить —
-- он не следит за site-packages/venv сам по себе. Автоматически
-- рестартуем его при сохранении файлов, где обычно меняются зависимости,
-- плюс ручной keymap на случай, если поставил зависимость мимо nvim
-- (например через терминал/lazygit-хук/CI).

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = {
    "pyproject.toml",
    "requirements*.txt",
    "poetry.lock",
    "uv.lock",
    "Pipfile",
    "Pipfile.lock",
  },
  callback = function()
    vim.cmd("LspRestart pyright")
    vim.notify("pyright перезапущен (новые зависимости)", vim.log.levels.INFO)
  end,
})

vim.keymap.set("n", "<leader>lr", "<cmd>LspRestart<cr>", { desc = "Перезапустить LSP-клиенты" })

return {}
