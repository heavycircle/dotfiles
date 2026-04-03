local hooks = function(ev)
	local name, kind = ev.data.spec.name, ev.data.kind

	if name == "nvim-treesitter" and (kind == "install" or kind == "update") then
		vim.cmd("TSUpdate")
	end
end

vim.api.nvim_create_autocmd("PackChanged", { callback = hooks })
vim.pack.add({
	"https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
	"https://github.com/nvim-treesitter/nvim-treesitter",
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
