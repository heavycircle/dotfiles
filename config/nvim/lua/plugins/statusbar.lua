local M = {}

function M.install()
	vim.pack.add({
		{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
		{ src = "https://github.com/nvim-lualine/lualine.nvim" },
	})
end

local function python_interpreter()
	if vim.bo.filetype ~= "python" then
		return ""
	end

	local venv = vim.env.VIRTUAL_ENV_PROMPT
	if venv then
		-- Extracts the last part of the path (the env name)
		local name = vim.fn.fnamemodify(venv, ":t")
		return " (" .. name .. ")"
	else
		return " Global"
	end
end

function M.setup()
	M.install()

	-- Setup a statusbar
	require("lualine").setup({
		options = {
			globalstatus = true,
			icons_enabled = true,
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { { "branch", icon = "" }, "diff" },
			lualine_c = { { "filename", path = 4 } },
			lualine_x = {
				{ python_interpreter, color = { fg = "#585b70" } },
				{ "diagnostics", sources = { "nvim_diagnostic" } },
				"filetype",
			},
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
	})
end

return M
