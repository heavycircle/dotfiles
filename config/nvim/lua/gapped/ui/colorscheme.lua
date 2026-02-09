MiniDeps.add({ source = "https://github.com/catppuccin/nvim" })

require("catppuccin").setup({
	flavour = "mocha",
	transparent_background = true,
	show_end_of_buffer = true,
	term_colors = false,
	integrations = {
		fzf = true,
		-- native_lsp = { enabled = true },
	},
})

-- Set the colorscheme
vim.cmd.colorscheme("catppuccin-mocha")
