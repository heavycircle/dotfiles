local lspconfig = require("lspconfig")
local utils = require("plugins.lsp.utils")
local null_ls = require("null-ls")

local M = {}

function M.install()
	vim.pack.add({
		{ src = "https://github.com/OXY2DEV/markview.nvim" },
	})
end

function M.setup()
	M.install()

	null_ls.setup({
		on_attach = utils.on_attach,
		capabilities = utils.capabilities,
		sources = {
			null_ls.builtins.diagnostics.cspell,
			null_ls.builtins.diagnostics.proselint,
		},
	})
end

return M
