vim.pack.add({
    { src = 'https://github.com/NvChad/showkeys', opt = true },
})

require "showkeys".setup({ position = "top-right" })

-- Colorscheme
require "plugins.colorscheme"
require "plugins.transparency"

-- Utility
require "plugins.telescope"
require "plugins.lsp"
require "plugins.statusbar"
require "plugins.snippets"
