local renamer = require("ui.renamer")
local signature = require("ui.signature")

local M = {}

M.capabilities = require("blink.cmp").get_lsp_capabilities()

M.on_attach = function(client, bufnr)
	if client.server_capabilities.signatureHelpProvider then
		signature.setup(client, bufnr)
	end

	vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "LSP Signature" })
	vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "LSP Signature Help" })
	vim.keymap.set("n", "<leader>cn", renamer, { buffer = bufnr, desc = "LSP Rename" })

	vim.keymap.set("n", "<leader>cq", function()
		vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
	end, { desc = "LSP: Toggle Inlay Hints" })
end

M.spelling = function()
	require("lspconfig").harper_ls.setup({
		settings = {
			["harper-ls"] = {
				linters = {
					SentenceCapitalization = false,
					SpellCheck = false,
				},
			},
		},
	})
end

return M
