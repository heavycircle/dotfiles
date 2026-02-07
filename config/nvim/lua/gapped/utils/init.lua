local renamer = require("gapped.utils.renamer")
local scratch = require("gapped.utils.scratch")
local signature = require("gapped.utils.signature")

local M = {}

M.capabilities = require("blink.cmp").get_lsp_capabilities()

M.on_attach = function(client, bufnr)
	if client.server_capabilities.signatureHelpProvider then
		signature.setup(client, bufnr)
	end

	vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "LSP Signature" })
	vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "LSP Signature Help" })
	vim.keymap.set("n", "<leader>cn", renamer, { buffer = bufnr, desc = "LSP Rename" })
end

M.scratch = scratch

return M
