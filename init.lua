local swapdir = vim.fn.stdpath("state") .. "/swap"
vim.fn.mkdir(swapdir, "p")
-- "//" в конце: имя swap-файла строится из полного пути файла (без коллизий одноимённых)
vim.opt.directory = swapdir .. "//"

require("core.options")
require("core.keymaps")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")
