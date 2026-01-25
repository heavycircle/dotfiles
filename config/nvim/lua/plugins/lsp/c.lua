local lspconfig = require("lspconfig")

local utils = require("plugins.lsp.utils")

local M = {}

function M.setup()
	lspconfig.clangd.setup({
		on_attach = utils.on_attach,
		capabilities = utils.capabilities,
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

	lspconfig.cmake.setup({
		on_attach = utils.on_attach,
		capabilities = utils.capabilities,
	})
end

return M
