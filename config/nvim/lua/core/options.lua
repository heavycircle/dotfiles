-- Vim Options. Changes from mini.basics.

-- Leader key
vim.g.mapleader = " "

-- Clipboard
vim.opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"

-- UI Changes
vim.opt.title = true
vim.opt.signcolumn = "yes"
vim.opt.winborder = "rounded"

-- Line Numbers
vim.opt.numberwidth = 2
vim.opt.relativenumber = true

-- Scrolling:
vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 4
