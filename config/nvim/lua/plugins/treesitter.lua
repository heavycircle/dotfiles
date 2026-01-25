-- Use the treesitter master branch because it's easier to configure

local M = {}

function M.install()
	vim.pack.add({
		{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "master", build = ":TSUpdate" },
	})
end

function M.setup()
	M.install()

	require("nvim-treesitter.configs").setup({
		ensure_installed = {
			"bash",
			"c",
			"cmake",
			"dockerfile",
			"lua",
			"python",
			"typescript",
			"prisma",
			"javascript",
			"html",
			"css",
			"json",
			"asm",
			"nasm",
		},

		sync_install = false,
		auto_install = true,
		highlight = { enable = true },
		indent = { enable = true },
	})

	vim.api.nvim_create_autocmd("FileType", {
		pattern = { "<filetype>" },
		callback = function()
			vim.treesitter.start()
		end,
	})

	vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
end

return M
