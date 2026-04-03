vim.pack.add({ "https://github.com/catppuccin/nvim" })

require("catppuccin").setup({
	flavour = "mocha",
	transparent_background = true,
	show_end_of_buffer = true,
	term_colors = false,
	integrations = { fzf = true },
})

-- Set the colorscheme
vim.cmd.colorscheme("catppuccin-mocha")
