add = vim.pack.add
later = MiniDeps.later
now = MiniDeps.now
now_if_args = _G.Config.now_if_args

now(function()
	require("gapped.plugins.files")
	require("gapped.plugins.other")

	require("gapped.ui.statusbar")
	require("gapped.ui.statuscolumn")
end)

now_if_args(function()
	require("gapped.plugins.treesitter")
	require("gapped.plugins.dap")
	require("gapped.plugins.lsp")
end)

later(function()
	require("gapped.plugins.autocomplete")
	require("gapped.plugins.docs")
	require("gapped.plugins.format")
	require("gapped.plugins.lint")
	require("gapped.plugins.luasnip")

	require("gapped.ui.appearance")
	require("gapped.ui.colorscheme")
	require("gapped.ui.diagnostics")

	require("gapped.plugins.local")
end)
