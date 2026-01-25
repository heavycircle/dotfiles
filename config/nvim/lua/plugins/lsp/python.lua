local utils = require("plugins.lsp.utils")
local lspconfig = require("lspconfig")
local null_ls = require("null-ls")

local M = {}

function M.setup()
	lspconfig.basedpyright.setup({
		on_attach = utils.on_attach,
		capabilities = utils.capabilities,
		root_dir = lspconfig.util.root_pattern("pyproject.toml", ".git"),
		settings = {
			basedpyright = {
				analysis = {
					typeCheckingMode = "strict",
					diagnosticMode = "openFilesOnly",
					useLibraryCodeForTypes = true,
					autoSearchPaths = true,
					inlayHints = {
						variableTypes = true,
						functionReturnTypes = true,
					},
				},
			},
		},
		before_init = function(_, config)
			config.settings.basedpyright.pythonPath = "./.venv/bin/python"
		end,
	})

	lspconfig.ruff.setup({
		on_attach = utils.on_attach,
		capabilities = utils.capabilities,
	})

	-- Pylint doesn't have an LSP so none-ls makes it
	null_ls.setup({
		on_attach = utils.on_attach,
		capabilities = utils.capabilities,
		sources = {
			null_ls.builtins.diagnostics.pylint.with({
				prefer_local = ".venv/bin",
			}),
			null_ls.builtins.diagnostics.mypy.with({
				prefer_local = ".venv/bin",
			}),
		},
	})

	-- TOML (for pyproject.toml)
	lspconfig.taplo.setup({
		on_attach = utils.on_attach,
		capabilities = utils.capabilities,
	})

	-- Format on Save
	vim.api.nvim_create_autocmd("BufWritePre", {
		pattern = "*.py",
		callback = function()
			vim.lsp.buf.code_action({
				context = { only = { "source.organizeImports" } },
				apply = true,
			})

			vim.lsp.buf.format({
				async = false,
				filter = function(client)
					return client.name == "ruff"
				end,
			})
		end,
	})

	vim.diagnostic.config({
		virtual_text = {
			-- Only show the first diagnostic if multiple exist on one line
			format = function(diagnostic)
				if diagnostic.source == "pylint" then
					return string.format("󰈚 %s", diagnostic.message)
				end
				return diagnostic.message
			end,
		},
	})

	vim.lsp.inlay_hint.enable(true)
end

return M
