MiniDeps.add({ source = "https://github.com/stevearc/oil.nvim" })

local oil_config = {
	columns = { "icon" },
	float = {
		padding = 2,
		max_width = 0.75,
		max_height = 0.75,
		win_options = {
			winblend = vim.o.winblend,
			winhl = "Normal:NormalFloat,FloatBorder:FloatBorder",
		},
	},
}

require("oil").setup(oil_config)

-- Oil does not update winblend.
_G.Config.new_autocmd("OptionSet", "winblend", function()
	oil_config.float.win_options.winblend = vim.v.option_new
	require("oil").setup(oil_config)
end, "Update Oil Winblend")
