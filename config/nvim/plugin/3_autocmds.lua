new_autocmd = _G.Config.new_autocmd

vim.api.nvim_create_user_command("W", "w", {})

new_autocmd("LspAttach", "*", function(args)
	vim.bo[args.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
end, "Hook Omnifunc")

new_autocmd("FileType", "*", function()
	pcall(vim.treesitter.start)
end, "Start Treesitter")
