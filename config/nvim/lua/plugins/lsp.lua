-- This file sets up LSP (and autocomplete) support for the file types I use.
--
-- The goal is to, as much as possible, extrapolate the locations where specific LSPs are
-- referenced to make it as easy as possible to setup more languages as necessary.
--
-- The current solution isn't perfect, but it's definitely a start. In my eyes, the main
-- issue is with nvim-lspconfig. Having this file around means having two places to handle
-- configurations, rather than one. In the future, I might take out lspconfig and start
-- manually defining configurations when I need them.

local M = {}

function M.get_langs()
    return {
        "bashls",                                                    -- Bash
        "clangd", "cmake",                                           -- C / CMake
        "docker_compose_language_service", "docker_language_server", -- Docker
        "hyprls",                                                    -- Hyprlang
        "lua_ls",                                                    -- Lua
        "harper_ls",                                                 -- Text files
        "pyright", "ruff",                                           -- Python
        "ts_ls", "prismals",                                         -- Webdev
    }
end

function M.install()
    vim.pack.add({
        { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "master", build = ":TSUpdate" },
        { src = 'https://github.com/neovim/nvim-lspconfig' },
        { src = "https://github.com/mason-org/mason.nvim" },
    })
end

function M.setup()
    M.install()

    -- Mason
    require "mason".setup()

    -- Autocomplete
    local capabilities = require("blink.cmp").get_lsp_capabilities()
    local langs = M.get_langs()
    for _, lsp in ipairs(langs) do
        vim.lsp.config(lsp, { capabilities = capabilities })
        vim.lsp.enable(lsp)
    end

    -- Error lens
    vim.diagnostic.config({ virtual_text = true })

    -- Error navigation
    vim.keymap.set("n", "[q", function() vim.diagnostic.jump({ count = -1, float = true }) end)
    vim.keymap.set("n", "]q", function() vim.diagnostic.jump({ count = 1, float = true }) end)
    vim.keymap.set("n", "<leader>xf", vim.diagnostic.open_float)
    vim.keymap.set("n", "<leader>xx", vim.diagnostic.setloclist)
end

return M
