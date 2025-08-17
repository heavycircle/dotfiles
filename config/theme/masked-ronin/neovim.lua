-- masked-ronin neovim theme

-- Add the package
vim.pack.add({
    { src = "https://github.com/heavycircle/ronin.nvim" }
})

-- Setup ronin options
require("ronin").setup({
    transparent = false,
    brighter_red = true,
    italics = { comments = true, keywords = true },
})

-- Set the theme
vim.cmd.colorscheme("ronin")
