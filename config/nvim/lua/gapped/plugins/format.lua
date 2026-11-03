vim.pack.add({ "https://github.com/stevearc/conform.nvim" })
conform = require("conform")

conform.setup({
	default_format_opts = {
		lsp_format = "fallback",
	},
	formatters = {
		["cmake-format"] = {
			command = "cmake-format",
			prepend_args = { "-i" },
		},
		fish_indent_tabs = {
			command = "sh",
			args = { "-c", "fish_indent | unexpand --first-only -t 4" },
		},
		mdformat = { prepend_args = { "--wrap", "keep" } },
	},
	formatters_by_ft = {
		bash = { "shfmt" },
		c = { "clang-format" },
		cmake = { "cmake-format" },
		cpp = { "clang-format" },
		css = { "prettier" },
		fish = { "fish_indent_tabs" },
		html = { "prettier" },
		lua = { "stylua" },
		json = { "prettier" },
		jsonc = { "prettier" },
		markdown = { "mdformat" },
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
_G.Config.new_autocmd("BufWritePre", "*", doc_format, "Format on Save")
