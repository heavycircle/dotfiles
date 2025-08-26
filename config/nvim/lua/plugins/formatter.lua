-- Many of the native LSPs support some sort of formatting. Why do we need this? The issue
-- is that they don't always use the formatters **we** want them to use. For example,
-- typescript has its own formatter, and vim.lsp.buf.format won't use prettier without
-- this plugin. Therefore, we use this plugin to simply define the formatter we want and
-- have our format keybind call conform.format. This also falls back to the LSP if we
-- haven't configured a keybind for that language.

local M = {}

function M.install()
    vim.pack.add({
        { src = 'https://github.com/stevearc/conform.nvim' },
    })
end

function M.setup()
    M.install()

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
            jsonc = { "prettier" },
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
end

return M
