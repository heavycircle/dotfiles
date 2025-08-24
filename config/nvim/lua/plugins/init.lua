-- This is the main plugin driver file.
-- I don't like that some plugins are configured in here.

vim.pack.add({
    { src = 'https://github.com/NvChad/showkeys',      opt = true },
    { src = 'https://github.com/stevearc/oil.nvim' },
    { src = 'https://github.com/wakatime/vim-wakatime' },
})

-- Showkeys
require "showkeys".setup({ position = "top-right" })

-- Oil
require "oil".setup()
vim.keymap.set("n", "<leader>e", "<cmd>Oil<CR>")

-- Colorscheme
require "plugins.colorscheme"
require "plugins.transparency"

-- Utility
require "plugins.autocomplete".setup()
require "plugins.formatter".setup()
require "plugins.telescope".setup()
require "plugins.lsp".setup()
require "plugins.luasnip".setup()
require "plugins.statusbar".setup()
require "plugins.treesitter".setup()

-- Custom stuff (gitignored)
require "plugins.custom"
