local M = {}

function M.get_langs()
    return { "bash", "c", "python", "typescript" }
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

    require "mason".setup()

    -- Share native capabilities with neovim ones.
    -- local capabilities = vim.lsp.protocol.make_client_capabilities()
    M.capabilities = require("blink.cmp").get_lsp_capabilities()

    -- Enable our known languages
    local langs = M.get_langs()
    for _, lsp in ipairs(langs) do
        require("plugins.lsp." .. lsp).setup()
    end

    -- Error lens
    vim.diagnostic.config({ virtual_text = true })

    vim.keymap.set("n", "[q", function() vim.diagnostic.jump({ count = -1, float = true }) end)
    vim.keymap.set("n", "]q", function() vim.diagnostic.jump({ count = 1, float = true }) end)
    vim.keymap.set("n", "<leader>xf", vim.diagnostic.open_float)
    vim.keymap.set("n", "<leader>xx", vim.diagnostic.setloclist)
end

return M
