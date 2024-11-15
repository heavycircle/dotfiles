-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap.set

-- Keep cursor positioning when using J and K (Source: The Primagen)
keymap("n", "J", "mzJ`z")

-- Keep cursor mid-page when using page up/down (Source: ThePrimagen)
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")

-- Keep cursor mid-page when searching (Source: ThePrimagen)
keymap("n", "N", "Nzzzv")
keymap("n", "n", "nzzzv")

-- Keep clipboard when pasting (Source: ThePrimagen)
keymap("x", "<leader>p", '"_dp')
keymap({ "x", "v" }, "<leader>d", '"_d')
