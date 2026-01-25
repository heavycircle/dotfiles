local signature = require("ui.signature")

local M = {}

function M.get_langs()
	return { "bash", "c", "lua", "python", "typescript" }
end

function M.install()
	vim.pack.add({
		{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "master", build = ":TSUpdate" },
		{ src = "https://github.com/neovim/nvim-lspconfig" },
		{ src = "https://github.com/mason-org/mason.nvim" },
		{ src = "https://github.com/nvimtools/none-ls.nvim" },
	})
end

function M.setup()
	M.install()

	require("mason").setup()

	-- Enable our known languages
	local langs = M.get_langs()
	for _, lsp in ipairs(langs) do
		require("plugins.lsp." .. lsp).setup()
	end

	-- Error lens
	vim.diagnostic.config({ virtual_text = true })

	vim.keymap.set("n", "[q", function()
		vim.diagnostic.jump({ count = -1, float = true })
	end)
	vim.keymap.set("n", "]q", function()
		vim.diagnostic.jump({ count = 1, float = true })
	end)

	-- Show source in open_float
	vim.keymap.set("n", "<leader>xf", function()
		vim.diagnostic.open_float({
			suffix = function(d)
				return (" [%s]"):format(d.source or "Unknown")
			end,
			focusable = true,
			border = "rounded",
		})
	end, { desc = "Show line diagnostics with source" })
end

return M
