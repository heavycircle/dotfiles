MiniDeps.add({ source = "https://github.com/danymat/neogen" })

require("neogen").setup({
	languages = {
		c = { template = { annotation_convention = "doxygen" } },
		cpp = { template = { annotation_convention = "doxygen" } },
		lua = { template = { annotation_convention = "emmylua" } },
		python = {
			template = {
				annotation_convention = "google_docstrings",
				add_parameter_types = true,
			},
		},
		sh = { template = { annotation_convention = "google_bash" } },
		typescript = { template = { annotation_convention = "tsdoc" } },
		typescriptreact = { template = { annotation_convention = "tsdoc" } },
	},
	snippet_engine = "luasnip",
})
