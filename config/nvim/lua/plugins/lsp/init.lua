-- LSP setup.
-- Providing auto-complete, warnings, etc. to the editor.

-- Add plugins
vim.pack.add({
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://github.com/mason-org/mason.nvim" },
    {
        src = "https://github.com/neovim/nvim-lspconfig",
        opts = {
            inlay_hints = { enabled = true },
        },
    }
})

-- Setup Mason
require("mason").setup()

-- Autoformat
vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format)

-- Add language support
require("plugins.lsp.bash")
require("plugins.lsp.cxx")
require("plugins.lsp.python")
require("plugins.lsp.lua")

-- Enable inlay hints
-- vim.lsp.inlay_hint.enable(")
