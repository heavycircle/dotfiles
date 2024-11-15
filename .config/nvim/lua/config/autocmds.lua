-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- set NASM as ASM
vim.cmd([[ autocmd BufRead,BufNewFile *.nasm set filetype=asm ]])
