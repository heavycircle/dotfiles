-- Install packages
vim.pack.add({
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
    { src = 'https://github.com/neovim/nvim-lspconfig' },
    { src = 'https://github.com/stevearc/conform.nvim' },
    { src = "https://github.com/mason-org/mason.nvim" },
})

-- Mason
require "mason".setup()

-- Enable needed LSPs
vim.lsp.enable({ "bashls" })                                                    -- Bash
vim.lsp.enable({ "clangd", "cmake" })                                           -- C / CMake
vim.lsp.enable({ "docker_compose_language_service", "docker_language_server" }) -- Docker
vim.lsp.enable({ "lua_ls" })                                                    -- Lua
vim.lsp.enable({ "harper_ls" })                                                 -- Text files
vim.lsp.enable({ "pyright", "ruff" })                                           -- Python
vim.lsp.enable({ "ts_ls", "prismals" })                                         -- Webdev

-- Code format
local conform = require "conform"
conform.setup({
    formatters = {
        -- shfmt should use 4 spaces
        shfmt = {
            append_args = { "-i", "4" },
        }
    },
    formatters_by_ft = {
        -- The web stack should use prettier
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        markdown = { "prettier" },
        json = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        -- The shells should use shfmt
        sh = { "shfmt" },
        bash = { "shfmt" },
        zsh = { "shfmt" },
        -- The C langs should use clang-format
        c = { "clang-format" },
        cpp = { "clang-format" },
        -- Python needs isort and black
        python = { "isort", "black" },
    }
})
vim.keymap.set('n', '<leader>cf', function() conform.format({ lsp_fallback = true }) end)

-- Error lens
vim.diagnostic.config({ virtual_text = true })

-- Error navigation
vim.keymap.set("n", "[q", function() vim.diagnostic.jump({ count = -1, float = true }) end)
vim.keymap.set("n", "]q", function() vim.diagnostic.jump({ count = 1, float = true }) end)
vim.keymap.set("n", "<leader>xf", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>xx", vim.diagnostic.setloclist)
