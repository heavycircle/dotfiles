local lsp = require("plugins.lsp")

local M = {}

function M.setup()
    vim.lsp.config("vtsls", {
        capabilities = capabilities,
        settings = {
            typescript = {
                inlayHints = {
                    parameterNames = { enabled = "all" },
                    variableTypes = { enabled = true },
                },
            },
        },
    })

    vim.lsp.config("prismals", { capabilities = capabilities })

    vim.lsp.config("cssls", { capabilities = capabilities })
    vim.lsp.config("jsonls", { capabilities = capabilities })

    vim.lsp.enable({ "vtsls", "prismals", "cssls", "jsonls" })
end

return M
