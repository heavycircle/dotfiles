-- Adjust semantic token highlighting
vim.api.nvim_set_hl(0, "@lsp.type.keyword.lua", { fg = "NONE" })
vim.api.nvim_set_hl(0, "@lsp.mod.documentation.lua", { link = "Statement" })

-- Add luarocks and VIMRUNTIME to the library
local lua_versions = vim.fn.glob(vim.fn.expand("~/.luarocks/share/lua/5.*"), false, true)
local library = { vim.env.VIMRUNTIME }
vim.list_extend(library, lua_versions)

return {
	settings = {
		Lua = {
			diagnostics = {
				disable = { "undefined-global" },
			},
			runtime = { version = "LuaJIT" },
			semanticTokens = { enable = true },
			workspace = {
				library = library,
				ignoreDir = { "dual", "deps" },
			},
		},
	},
}
