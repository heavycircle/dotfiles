-- Git support.
--

vim.pack.add({
    { 
        src = "https://github.com/lewis6991/gitsigns.nvim",
        opts = {
            signcolumn = true,
            auto_attach = true,
            attach_to_untracked = false,
            current_line_blame = true
        }
    }
})

