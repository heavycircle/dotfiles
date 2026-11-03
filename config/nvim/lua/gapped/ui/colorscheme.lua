vim.pack.add({ "https://github.com/catppuccin/nvim", "https://github.com/rebelot/kanagawa.nvim" })

require("catppuccin").setup({
	flavour = "mocha",
	transparent_background = true,
	show_end_of_buffer = true,
	term_colors = false,
	integrations = { fzf = true },
})

require("kanagawa").setup({
	theme = "dragon",
	transparent = true,
	terminalColors = false,
	colors = {
		-- Let the transparent background show through the sign/number column too
		theme = { all = { ui = { bg_gutter = "none" } } },
	},
})

-- Set the colorscheme (switch at runtime with `:colorscheme catppuccin-mocha`)
vim.cmd.colorscheme("kanagawa-dragon")
