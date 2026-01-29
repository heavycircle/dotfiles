-- Many of the native LSPs support some sort of formatting. Why do we need this? The issue
-- is that they don't always use the formatters **we** want them to use. For example,
-- typescript has its own formatter, and vim.lsp.buf.format won't use prettier without
-- this plugin. Therefore, we use this plugin to simply define the formatter we want and
-- have our format keybind call conform.format. This also falls back to the LSP if we
-- haven't configured a keybind for that language.

local M = {}

function M.install()
	vim.pack.add({
		{ src = "https://github.com/stevearc/conform.nvim" },
	})
end

function M.setup()
	M.install()

	local conform = require("conform")
	conform.setup({
		formatters = {
			-- shfmt should use 4 spaces
			shfmt = {
				append_args = { "-i", "4" },
			},
			prettier = {
				condition = function(self, ctx)
					return vim.fs.find(
						{ ".prettierrc", ".prettierrc.json", "prettier.config.js" },
						{ path = ctx.filename, upward = true }
					)[1] ~= nil
				end,
			},
		},
		formatters_by_ft = {
			-- python: ruff
			python = { "ruff_format", "ruff_organize_imports" },
			-- c: clang-format
			c = { "clang-format" },
			cpp = { "clang-format" },
			-- web: prettier
			typescript = { "prettier" },
			typescriptreact = { "prettier" },
			javascript = { "prettier" },
			javascriptreact = { "prettier" },
			markdown = { "prettier" },
			json = { "prettier" },
			jsonc = { "prettier" },
			css = { "prettier" },
			html = { "prettier" },
			-- sh: shfmt
			sh = { "shfmt" },
			bash = { "shfmt" },
			zsh = { "shfmt" },
			-- lua: stylua
			lua = { "stylua" },
		},
		format_on_save = function(bufnr)
			return { timeout_ms = 500, lsp_fallback = true }
		end,
	})

	vim.keymap.set("n", "<leader>cf", function()
		conform.format({ lsp_fallback = true })
	end)
end

return M
