local lsp = require("plugins.lsp")

local M = {}

function M.setup()
    vim.lsp.config("bashls", { capabilities = capabilities })

    vim.lsp.enable({ "bashls" })
end

return M
