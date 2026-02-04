local M = {}

function M.install()
	vim.pack.add({
		{ src = "https://github.com/nvim-mini/mini.nvim" },
	})
end

function M.setup()
	M.install()

	-- Integrated in 0.12.0
	require("mini.bracketed").setup()
	require("mini.comment").setup()

	-- Nerd Font Required
	require("mini.icons").setup()
	require("mini.icons").mock_nvim_web_devicons()

	-- Actually unique config
	require("mini.ai").setup()
	require("mini.basics").setup({ options = { extra_ui = true } })
	require("mini.hipatterns").setup({
		fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
		hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
		todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
		note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
	})
	-- require("mini.git").setup()
	require("mini.indentscope").setup()
	require("mini.notify").setup()
	require("mini.pairs").setup()
	require("mini.surround").setup()
end

return M
