-- Vim Options.
-- These can all be changed with 'set X=Y'

-- Leader key
vim.g.mapleader = " "

-- Clipboard (sync with global)
vim.opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"

-- Spaces. Four of them.
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

-- UI Changes
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showmode = false
vim.opt.signcolumn = "yes" -- Still don't know why this isn't true
vim.opt.termguicolors = true
vim.opt.winborder = "rounded"

-- Scrolling: Always keep 8 lines 
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- Window-splitting
vim.opt.splitbelow = true
vim.opt.splitkeep = "screen"
vim.opt.splitright = true

-- Use an undo directory
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undolevels = 10000
vim.opt.updatetime = 200
