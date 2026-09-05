-- dotnet global tools (EasyDotnet, roslyn-language-server) для easy-dotnet.nvim
-- WSL Arch: dotnet tool install -g кладет в ~/.dotnet/tools, но nvim PATH без него -> E475 dotnet-easydotnet not executable
vim.env.PATH = vim.fn.expand("~/.dotnet/tools") .. ":" .. vim.env.PATH

-- Aliases
local opt = vim.opt

-- Leader Key
vim.g.mapleader = " "

-- Visual and Navigation
opt.number = true
-- opt.relativenumber = true
opt.cursorline = true
opt.scrolloff = 8
opt.signcolumn = "yes"

opt.list = true
opt.listchars = {
    space = ".",
    tab = "| ",
    trail = "·",
    nbsp = "⍽",
}

-- Font
vim.o.guifont = "JetBrainsMono Nerd Font:h16"
vim.opt.linespace = 8

-- Tabs
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

-- Splits
opt.splitright = true
opt.splitbelow = true

-- Ctrl + V
opt.clipboard = "unnamedplus"

-- Search
opt.ignorecase = true
opt.smartcase = true

-- File System and Memory
opt.swapfile = false
opt.undofile = true

opt.updatetime = 250
opt.termguicolors = true
opt.wrap = false
