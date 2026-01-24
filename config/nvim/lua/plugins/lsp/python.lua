local lsp = require("plugins.lsp")

local M = {}

function M.setup()
    vim.lsp.config("pyright", {
        capabilities = lsp.capabilities,
        settings = {
            python = { 
                analysis = {
                    typeCheckingMode = "strict",
                    autoSearchPaths = true,
                    useLibraryCodeForTypes = true,
                    diagnosticMode = "workspace",
                    inlayHints = {
                        variableTypes = true,
                        functionReturnTypes = true,
                    },
                },
            },
        },
    })

    vim.lsp.config("ruff", {
        capabilities = lsp.capabilities,
    })

    vim.lsp.config("taplo", {
        capabilities = lsp.capabilities,
        settings = {
            evenBetterToml = {
                schema = { enabled = true },
            },
        },
    })

    vim.lsp.enable({ "pyright", "ruff", "taplo" })
end

return M
