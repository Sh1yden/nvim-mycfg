-- Настройки применяются только внутри Neovide (GUI), в терминале
-- vim.g.neovide не существует и весь блок просто не выполняется.
if not vim.g.neovide then
	return {}
end

vim.g.neovide_cursor_animation_length = 0.08
vim.g.neovide_cursor_trail_size = 0.5

vim.g.neovide_scroll_animation_length = 0.25

vim.g.neovide_opacity = 0.73
vim.g.neovide_window_blurred = true

vim.g.neovide_padding_top = 10
vim.g.neovide_padding_bottom = 10
vim.g.neovide_padding_left = 12
vim.g.neovide_padding_right = 12

return {}
