-- Keymaps file.

-- Slide lines up and down
vim.keymap.set("v", "J", ":m >+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m <-2<CR>gv=gv")

-- Accepting autocomplete
vim.keymap.set("i", "<C-Space>", "<C-x><C-o>", { noremap = true })
vim.keymap.set("i", "<C-e>", "<C-e>", { noremap = true })

-- Keep cursor positioning when using J and K
vim.keymap.set("n", "J", "mzJ`z")

-- Keep cursor mid-page when page up/down
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Keep cursor mid-page when searching
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "n", "nzzzv")

-- Keep clipboard when pasting with <leader>
vim.keymap.set("x", "<leader>p", '"_dp')
vim.keymap.set({ "x", "v" }, "<leader>d", '"_d')

-- Better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Me function
vim.keymap.set("i", "<C-l>", function()
    local date = os.date("%B %d, %Y")
    return string.format("\nAuthor: heavycircle\nDate: %s\nLicense: MIT", date)
end, { expr = true })
