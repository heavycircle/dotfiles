new_autocmd = _G.Config.new_autocmd

vim.api.nvim_create_user_command("W", "w", {})

new_autocmd("LspAttach", "*", function(args)
	vim.bo[args.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
end, "Hook Omnifunc")

new_autocmd("FileType", "*", function()
	pcall(vim.treesitter.start)
end, "Start Treesitter")

new_autocmd("LspAttach", "*", function(args)
	local client = vim.lsp.get_client_by_id(args.data.client_id)
	if not client then
		return
	end

	if client:supports_method("textDocument/formatting") then
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = args.buf,
			callback = function()
				require("conform").format({ bufnr = args.buf })
			end,
		})
	end
end, "Format on Save")
