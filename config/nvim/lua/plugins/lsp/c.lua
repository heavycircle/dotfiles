local lsp = require("plugins.lsp")

local M = {}

function M.setup()
    vim.lsp.config("clangd", {
        capabilities = lsp.capabilities,
        cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--completion-style=detailed",
            "--tweaks=-std=c99",
        },
    })

    vim.lsp.config("cmake", {
        capabilities = lsp.capabilities,
    })

    vim.lsp.enable({ "clangd", "cmake"  })
end

return M
