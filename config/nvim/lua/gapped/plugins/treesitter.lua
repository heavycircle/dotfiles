MiniDeps.add({
	source = "nvim-treesitter/nvim-treesitter",
	depends = { "nvim-treesitter/nvim-treesitter-textobjects" },
	hooks = {
		post_checkout = function()
			vim.cmd("TSUpdate")
		end,
	},
})

require("nvim-treesitter").setup({
	ensure_installed = {
		"bash",
		"c",
		"cmake",
		"cpp",
		"css",
		"dockerfile",
		"lua",
		"python",
		"typescript",
		"prisma",
		"javascript",
		"html",
		"json",
		"asm",
		"nasm",
		"rust",
	},

	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	indent = { enable = true },
})
