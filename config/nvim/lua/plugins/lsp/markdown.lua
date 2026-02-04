local M = {}

function M.install()
	vim.pack.add({
		{ src = "https://github.com/OXY2DEV/markview.nvim" },
	})
end

function M.setup()
	M.install()
end

return M
