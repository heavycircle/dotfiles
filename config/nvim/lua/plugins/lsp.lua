-- Install packages
vim.pack.add({
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
    { src = 'https://github.com/neovim/nvim-lspconfig' },
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

-- Code format
vim.keymap.set('n', '<leader>cf', vim.lsp.buf.format)

-- Error lens
vim.diagnostic.config({ virtual_text = true })

-- Error navigation
vim.keymap.set("n", "[q", function() vim.diagnostic.jump({ count = -1, float = true }) end)
vim.keymap.set("n", "]q", function() vim.diagnostic.jump({ count = 1, float = true }) end)
vim.keymap.set("n", "<leader>xf", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>xx", vim.diagnostic.setloclist)
