-- Vim Options.
-- These can all be changed with 'set X=Y'

-- Leader key
vim.g.mapleader = " "

-- Clipboard (sync with global)
vim.opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"

-- UTF-8 encoding
vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

-- Spaces. Four of them.
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.smarttab = true
vim.opt.tabstop = 4

-- UI Changes
vim.opt.completeopt = "menuone,noselect,popup"

vim.opt.termguicolors = true
vim.opt.title = true
vim.opt.winborder = "rounded"

-- Remove the original status line
vim.opt.cmdheight = 0
vim.opt.laststatus = 0
vim.opt.showcmd = true
vim.opt.showmode = false

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"

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
