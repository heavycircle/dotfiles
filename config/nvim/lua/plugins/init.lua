vim.pack.add({
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
    { src = "https://github.com/chomosuke/typst-preview.nvim" },
    { src = 'https://github.com/neovim/nvim-lspconfig' },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = 'https://github.com/NvChad/showkeys',                 opt = true },
    { src = "https://github.com/L3MON4D3/LuaSnip" },
})

require "showkeys".setup({ position = "top-right" })

require "plugins.colorscheme"
require "plugins.transparency"

---- LSP CONFIGURATION -----------------------------------------

-- Mason
require "mason".setup()

-- Treesitter
-- require('nvim-treesitter.configs').setup({ highlight = { enable = true, }, })

-- Telescope
require("plugins.telescope")

-- LSPs
vim.lsp.enable({ "bashls" })                                                    -- Bash
vim.lsp.enable({ "clangd", "cmake" })                                           -- C / CMake
vim.lsp.enable({ "docker_compose_language_service", "docker_language_server" }) -- Docker
vim.lsp.enable({ "lua_ls" })                                                    -- Lua
vim.lsp.enable({ "pyright", "ruff" })                                           -- Python

-- Code format
vim.keymap.set('n', '<leader>cf', vim.lsp.buf.format)

-- Error lens
vim.diagnostic.config({ virtual_text = true })

-- Error navigation
vim.keymap.set("n", "[q", function() vim.diagnostic.jump({ count = -1, float = true }) end)
vim.keymap.set("n", "]q", function() vim.diagnostic.jump({ count = 1, float = true }) end)
vim.keymap.set("n", "<leader>xf", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>xx", vim.diagnostic.setloclist)

---- COLORSCHEME -----------------------------------------------


---- SNIPPETS --------------------------------------------------

require("luasnip").setup({ enable_autosnippets = true })
require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/" })
local ls = require("luasnip")
vim.keymap.set("i", "<C-e>", function() ls.expand_or_jump(1) end, { silent = true })
-- vim.keymap.set({ "i", "s" }, "<C-J>", function() ls.jump(1) end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-K>", function() ls.jump(-1) end, { silent = true })
