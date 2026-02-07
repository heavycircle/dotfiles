MiniDeps.add({ source = "https://github.com/stevearc/oil.nvim" })

require("oil").setup({
	float = {
        padding = 2,
        max_width = 0.5,
        max_height = 0.5,
		border = vim.o.winborder ~= "" and vim.o.winborder or "rounded",
		win_options = {
			winhl = "Normal:NormalFloat,FloatBorder:FloatBorder",
		},
	},
})
