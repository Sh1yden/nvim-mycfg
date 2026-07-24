return {
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		-- Скачивание готового бинарника (mkdp#util#install) не подходит под
		-- свежие версии Node (нет собранного релиза под них) — собираем
		-- зависимости из исходников через npm.
		build = "cd app && npm install",
		keys = {
			{ "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown preview", ft = "markdown" },
		},
	},
}
