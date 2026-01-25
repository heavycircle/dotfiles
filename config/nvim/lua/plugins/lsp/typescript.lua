local lspconfig = require("lspconfig")
local utils = require("plugins.lsp.utils")

local M = {}

function M.setup()
	lspconfig.vtsls.setup({
		on_attach = utils.on_attach,
		capabilities = utils.capabilities,
		settings = {
			typescript = {
				inlayHints = {
					parameterNames = { enabled = "all" },
					parameterTypes = { enabled = true },
					propertyDeclarationTypes = { enabled = true },
					functionLikeReturnTypes = { enabled = true },
					enumMemberValues = { enabled = true },
				},
			},
		},
	})

	lspconfig.prismals.setup({
		on_attach = utils.on_attach,
		capabilities = utils.capabilities,
	})

	lspconfig.cssls.setup({
		on_attach = utils.on_attach,
		capabilities = utils.capabilities,
	})
	lspconfig.jsonls.setup({
		on_attach = utils.on_attach,
		capabilities = utils.capabilities,
	})
end

return M
