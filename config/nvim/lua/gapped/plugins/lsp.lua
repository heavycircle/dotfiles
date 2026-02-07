MiniDeps.add({ source = "https://github.com/neovim/nvim-lspconfig" })
require("gapped.plugins.autocomplete")

vim.lsp.config("*", {
	on_attach = function(client, _bufnr)
		-- Prefer treesitter colors
		client.server_capabilities.semanticTokensProvider = nil
	end,
})

local servers =
	{ "basedpyright", "bashls", "clangd", "cssls", "emmylua_ls", "neocmake", "jsonls", "prismals", "ruff", "taplo", "vtsls" }

local utils = require("gapped.utils")
for _, server in ipairs(servers) do
	vim.lsp.config[server] = vim.tbl_deep_extend("force", vim.lsp.config[server] or {}, {
		on_attach = utils.on_attach,
		capabilities = utils.capabilities,
	})

	vim.lsp.enable(server)
end
