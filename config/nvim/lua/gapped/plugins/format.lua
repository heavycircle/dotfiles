MiniDeps.add({ source = "https://github.com/stevearc/conform.nvim" })
conform = require("conform")

conform.setup({
	default_format_opts = {
		lsp_format = "fallback",
	},
	formatters = {
		shfmt = { append_args = { "-i", "4" } },
	},
	formatters_by_ft = {
		bash = { "shfmt" },
		c = { "clang-format" },
		cpp = { "clang-format" },
		css = { "prettier" },
		html = { "prettier" },
		lua = { "stylua" },
		json = { "prettier" },
		jsonc = { "prettier" },
		markdown = { "prettier" },
		javascript = { "prettier" },
		javascriptreact = { "prettier" },
		typescript = { "prettier" },
		typescriptreact = { "prettier" },
		python = { "ruff_format", "ruff_organize_imports" },
		sh = { "shfmt" },
		zsh = { "shfmt" },
	},
})

-- Format on save
local doc_format = function(ev)
        conform.format()	
end
_G.Config.new_autocmd("BufWritePre", "<filetype>", doc_format, "Format on Save")
