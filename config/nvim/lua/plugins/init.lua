vim.pack.add({
    { src = 'https://github.com/NvChad/showkeys',      opt = true },
    { src = 'https://github.com/stevearc/oil.nvim' },
    { src = 'https://github.com/wakatime/vim-wakatime' },
})

require "showkeys".setup({ position = "top-right" })

-- Oil
require "oil".setup()
vim.keymap.set("n", "<leader>e", "<cmd>Oil<CR>")

-- Colorscheme
require "plugins.colorscheme"
require "plugins.transparency"

-- Utility
require "plugins.telescope"
require "plugins.lsp"
require "plugins.statusbar"
require "plugins.snippets"
