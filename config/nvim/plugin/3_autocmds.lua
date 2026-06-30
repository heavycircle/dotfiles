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
