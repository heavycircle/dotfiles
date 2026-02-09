MiniDeps.add({ source = "https://github.com/neovim/nvim-lspconfig" })
require("gapped.plugins.autocomplete")

vim.lsp.config("*", {
	on_attach = function(client, _bufnr)
		-- Prefer treesitter colors
		client.server_capabilities.semanticTokensProvider = nil
	end,
})

local servers = {
	"basedpyright",
	"bashls",
	"clangd",
	"cssls",
	"emmylua_ls",
	"neocmake",
	"jsonls",
	"prismals",
	"ruff",
	"taplo",
	"vtsls",
}

for _, server in ipairs(servers) do
	vim.lsp.config[server] = vim.tbl_deep_extend("force", vim.lsp.config[server] or {}, {
		capabilities = require("blink.cmp").get_lsp_capabilities(),
	})

	vim.lsp.enable(server)
end
