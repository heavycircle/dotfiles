vim.pack.add({ "https://github.com/rebelot/kanagawa.nvim" })

require("kanagawa").setup({
	theme = "dragon",
	transparent = true,
	terminalColors = false,
	colors = {
		-- Let the transparent background show through the sign/number column too
		theme = { all = { ui = { bg_gutter = "none" } } },
	},
})

-- Set the colorscheme
vim.cmd.colorscheme("kanagawa-dragon")
