-- Adjust semantic token highlighting
vim.api.nvim_set_hl(0, "@lsp.type.keyword.lua", { fg = "NONE" })
vim.api.nvim_set_hl(0, "@lsp.mod.documentation.lua", { link = "Statement" })

return {
	settings = {
		Lua = {
			diagnostics = {
				disable = { "undefined-global" },
			},
			runtime = { version = "LuaJIT" },
			semanticTokens = { enable = true },
			workspace = {
				library = { vim.env.VIMRUNTIME },
				ignoreDir = { "dual", "deps" },
			},
		},
	},
}
