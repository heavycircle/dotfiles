new_autocmd = _G.Config.new_autocmd

vim.api.nvim_create_user_command("W", "w", {})

new_autocmd("FileType", "markdown", function()
	vim.opt_local.wrap = true
	vim.opt_local.linebreak = true
	vim.opt_local.breakindent = true
end, "Preview Markdown")

new_autocmd("LspAttach", "*", function(args)
	vim.bo[args.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
end, "Hook Omnifunc")

new_autocmd("FileType", "*", function()
	pcall(vim.treesitter.start)
end, "Start Treesitter")

new_autocmd("VimEnter", "*", function()
	if vim.fn.argc() == 0 then
		return
	end

	local arg = vim.fn.argv(0)
	local path = arg:gsub("^oil://", "")

	if vim.fn.isdirectory(path) == 1 then
		vim.api.nvim_set_current_dir(path)
	end
end, "Fix Current Directory given argument")
