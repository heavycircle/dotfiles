local M = {}

function M.install()
	vim.pack.add({
		{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	})
end

function M.setup()
	M.install()

	require("gitsigns").setup({})
end

return M
