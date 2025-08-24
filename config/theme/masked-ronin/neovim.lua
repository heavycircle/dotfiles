-- masked-ronin neovim theme

-- Add the package
vim.pack.add({
    { src = "https://github.com/heavycircle/ronin.nvim" }
})

-- Setup ronin options
require("ronin").setup({
    transparent = true,
    plugins = {
        all = true
    }
})

-- Set the theme
vim.cmd.colorscheme("ronin")
