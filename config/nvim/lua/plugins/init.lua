vim.pack.add({
    { src = "https://github.com/catppuccin/nvim" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
    { src = "https://github.com/chomosuke/typst-preview.nvim" },
    { src = 'https://github.com/neovim/nvim-lspconfig' },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = 'https://github.com/NvChad/showkeys',                 opt = true },
    { src = "https://github.com/L3MON4D3/LuaSnip" },
})

require "mason".setup()
require "showkeys".setup({ position = "top-right" })

vim.keymap.set('n', '<leader>f', ":Pick files<CR>")
vim.keymap.set('n', '<leader>h', ":Pick help<CR>")
vim.keymap.set('n', '<leader>e', ":Oil<CR>")
vim.keymap.set('t', '', "")
vim.keymap.set('t', '', "")

---- LSP CONFIGURATION -----------------------------------------

-- Treesitter
require('nvim-treesitter.configs').setup({ highlight = { enable = true, }, })

-- LSPs
vim.lsp.enable({ "bashls", "shellcheck", "shfmt" })                                  -- Bash
vim.lsp.enable({ "clangd", "cmakelang", "cmakelint" })                               -- C / CMake
vim.lsp.enable({ "docker-compose-language-service", "dockerfile-language-service" }) -- Docker
vim.lsp.enable({ "lua_ls" })                                                         -- Lua
vim.lsp.enable({ "black", "pyright", "ruff" })                                       -- Python

-- Code format
vim.keymap.set('n', '<leader>cf', vim.lsp.buf.format)

-- Error lens
vim.diagnostic.config({ virtual_text = true })

-- Error navigation
vim.keymap.set("n", "[q", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]q", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>xf", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>xx", vim.diagnostic.setloclist)

---- COLORSCHEME -----------------------------------------------

require("catppuccin").setup({
    flavour = "mocha",
    transparent_background = false,
    show_end_of_buffer = false,
    term_colors = false,
    styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        functions = {},
        loops = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
    },
    integrations = {
        fzf = true,
        native_lsp = {
            enabled = true,
            virtual_text = {
                errors = { "italic" },
                hints = { "italic" },
                warnings = { "italic" },
                information = { "italic" },
                ok = { "italic" },
            },
            underlines = {
                errors = { "underline" },
                hints = { "underline" },
                warnings = { "underline" },
                information = { "underline" },
                ok = { "underline" },
            },
            inlay_hints = {
                background = true,
            },
        },
    }
})
vim.cmd.colorscheme "catppuccin"

---- SNIPPETS --------------------------------------------------

require("luasnip").setup({ enable_autosnippets = true })
require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/" })
local ls = require("luasnip")
vim.keymap.set("i", "<C-e>", function() ls.expand_or_jump(1) end, { silent = true })
-- vim.keymap.set({ "i", "s" }, "<C-J>", function() ls.jump(1) end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-K>", function() ls.jump(-1) end, { silent = true })
