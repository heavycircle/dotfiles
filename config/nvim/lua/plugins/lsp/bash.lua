local lspconfig = require("lspconfig")
local null_ls = require("null-ls")
local utils = require("plugins.lsp.utils")

local M = {}

function M.setup()
	lspconfig.bashls.setup({
		on_attach = utils.on_attach,
		capabilities = utils.capabilities,
		filetypes = { "sh", "bash" },
	})

	null_ls.register({
		null_ls.builtins.diagnostics.shellcheck,
	})

	vim.api.nvim_create_autocmd("BufWritePre", {
		pattern = { "*.sh", "*.bash" },
		callback = function()
			vim.lsp.buf.format({ async = false })
		end,
	})
end

return M
