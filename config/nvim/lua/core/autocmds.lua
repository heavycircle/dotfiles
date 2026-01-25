-- Autocommands

-- .nasm is an ASM file
vim.cmd([[ autocmd BufRead,BufNewFile *.nasm set filetype=asm ]])

-- Remove the background
vim.cmd(":hi statusline guibg=NONE")

-- Hook LSP omnifunc
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		vim.bo[args.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
	end,
})

-- Add :W command
vim.api.nvim_create_user_command("W", "w", {})

-- Start Treesitter
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "<filetype>" },
	callback = function()
		vim.treesitter.start()
	end,
})
