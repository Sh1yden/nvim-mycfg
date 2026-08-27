return {
	{
		"HiPhish/rainbow-delimiters.nvim",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			-- Дефолтные цвета rainbow-delimiters не совпадают с палитрой Kanagawa —
			-- переопределяем группы явными hex из самой темы. Вешаем на ColorScheme,
			-- иначе при (пере)загрузке темы кастомные цвета слетят на дефолтные.
			local function set_kanagawa_rainbow_colors()
				vim.api.nvim_set_hl(0, "RainbowDelimiterRed", { fg = "#d27472" }) -- autumnRed
				vim.api.nvim_set_hl(0, "RainbowDelimiterOrange", { fg = "#FFA066" }) -- surimiOrange
				vim.api.nvim_set_hl(0, "RainbowDelimiterYellow", { fg = "#DCA561" }) -- autumnYellow
				vim.api.nvim_set_hl(0, "RainbowDelimiterGreen", { fg = "#98BB6C" }) -- springGreen
				vim.api.nvim_set_hl(0, "RainbowDelimiterCyan", { fg = "#7AA89F" }) -- waveAqua2
				vim.api.nvim_set_hl(0, "RainbowDelimiterBlue", { fg = "#7E9CD8" }) -- crystalBlue
				vim.api.nvim_set_hl(0, "RainbowDelimiterViolet", { fg = "#957FB8" }) -- oniViolet
			end

			set_kanagawa_rainbow_colors()
			vim.api.nvim_create_autocmd("ColorScheme", {
				callback = set_kanagawa_rainbow_colors,
			})

			require("rainbow-delimiters.setup").setup({
				highlight = {
					"RainbowDelimiterViolet",
					"RainbowDelimiterOrange",
					"RainbowDelimiterBlue",
					"RainbowDelimiterRed",
					"RainbowDelimiterYellow",
					"RainbowDelimiterGreen",
					"RainbowDelimiterCyan",
				},
			})
		end,
	},
	{
		"brenoprata10/nvim-highlight-colors",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			render = "background", -- можно "foreground" или "first_column"
			enable_named_colors = true,
			enable_tailwind = true,
		},
	},
}
