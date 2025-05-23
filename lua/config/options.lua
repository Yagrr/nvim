-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Block cursor during insert mode
vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.g.mapleader = " "

-- Disable snacks animation
vim.g.snacks_animate = false

-- Code Folding
vim.o.foldlevel = 20
-- Opens all folds when opening file
vim.o.foldlevelstart = 99

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

if vim.loop.os_uname().sysname == "Windows_NT" then
  -- WINDOWS ONLY: setting undodir
  vim.opt.undodir = os.getenv("USERPROFILE") .. "/.vim/undodir"
else
  vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
end

-- WINDOWS ONLY: settings Windows shell
if vim.loop.os_uname().sysname == "Windows_NT" then
  vim.o.shell = "C:\\WINDOWS\\system32\\cmd.exe"
end
