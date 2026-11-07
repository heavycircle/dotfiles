vim.pack.add({
	"https://github.com/catppuccin/nvim",
	"https://github.com/rebelot/kanagawa.nvim",
	"https://github.com/EdenEast/nightfox.nvim",
})

-- Default Theme
require("catppuccin").setup({
	flavour = "mocha",
	transparent_background = true,
	show_end_of_buffer = true,
	term_colors = false,
	integrations = { fzf = true },
})

-- Ultron
require("kanagawa").setup({
	theme = "dragon",
	transparent = true,
	terminalColors = false,
	colors = {
		-- Let the transparent background show through the sign/number column too
		theme = { all = { ui = { bg_gutter = "none" } } },
	},
})

-- Samurai
require("nightfox").setup({
	options = {
		transparent = true,
	},
})

-- Set the colorscheme
vim.cmd.colorscheme("catppuccin-mocha")
