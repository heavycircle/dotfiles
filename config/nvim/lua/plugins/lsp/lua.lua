local utils = require("plugins.lsp.utils")
local lspconfig = require("lspconfig")

local M = {}

function M.setup()
	lspconfig.lua_ls.setup({
		on_attach = utils.on_attach,
		capabilities = utils.capabilities,
		settings = {
			Lua = {
				runtime = { version = "LuaJIT" },
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					library = vim.api.nvim_get_runtime_file("", true),
					checkThirdParty = false,
				},
				telemetry = { enabled = false },
			},
		},
	})

	local null_ls = require("null-ls")
	null_ls.register(null_ls.builtins.formatting.stylua)

	vim.api.nvim_create_autocmd("BufWritePre", {
		pattern = "*.lua",
		callback = function()
			vim.lsp.buf.format({ async = false })
		end,
	})
end

return M
