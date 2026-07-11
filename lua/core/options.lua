-- Aliases
local opt = vim.opt

-- Leader Key
vim.g.mapleader = " "

-- Visual and Navigation
opt.number = true
-- opt.relativenumber = true
opt.cursorline = true

opt.list = true -- invisible symbols
opt.listchars = {
    space = ".",
    tab = "| ",
    trail = "·",
    nbsp = "⍽",
}


-- Tabs
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

-- Ctrl + V
opt.clipboard = "unnamedplus"

-- Search
opt.ignorecase = true -- test = Test, test itd.
opt.smartcase = true -- Test = only Test.

-- File System and Memory
opt.swapfile = false
opt.undofile = true

opt.updatetime = 250

