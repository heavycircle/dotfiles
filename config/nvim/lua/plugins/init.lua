vim.pack.add({
    { src = 'https://github.com/NvChad/showkeys', opt = true },
    { src = 'https://github.com/stevearc/oil.nvim' },
})

require "oil".setup()
require "showkeys".setup({ position = "top-right" })

vim.keymap.set("n", "<leader>e", "<cmd>Oil<CR>", help="Oil")

-- Colorscheme
require "plugins.colorscheme"
require "plugins.transparency"

-- Utility
require "plugins.telescope"
require "plugins.lsp"
require "plugins.statusbar"
require "plugins.snippets"
