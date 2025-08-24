-- Keymaps file.

----------------------------------------------------------------
--  BETTER CURSOR                                             --
----------------------------------------------------------------

-- Keep cursor positioning when using J and K
vim.keymap.set("n", "J", "mzJ`z")

-- Keep cursor mid-page when page up/down
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Keep cursor mid-page when searching
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "n", "nzzzv")

-- Better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

----------------------------------------------------------------
--  BETTER CLIPBOARD                                          --
----------------------------------------------------------------

-- Don't put 'x' deletes in keyboard
vim.keymap.set("n", "x", '"_x')

-- Slide lines up and down
vim.keymap.set("v", "J", ":m >+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m <-2<CR>gv=gv")

-- Keep clipboard when pasting with <leader>
vim.keymap.set("x", "<leader>p", '"_dp')
vim.keymap.set({ "x", "v" }, "<leader>d", '"_d')

----------------------------------------------------------------
--  PLUGIN KEYBINDS                                           --
----------------------------------------------------------------

-- Accepting autocomplete
vim.keymap.set("i", "<C-Space>", "<C-x><C-o>", { noremap = true })
vim.keymap.set("i", "<C-e>", "<C-e>", { noremap = true })

-- Oil.nvim
vim.keymap.set("n", "<leader>e", "<cmd>Oil<CR>")
