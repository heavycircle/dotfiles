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
            "--header-insertion=never",
        },
        init_options = {
            fallbackFlags = { "-std=c99" },
            compilationDatabasePath = "build",
        },
    })

    vim.lsp.config("cmake", {
        capabilities = lsp.capabilities,
    })

    vim.lsp.enable({ "clangd", "cmake"  })
end

return M
