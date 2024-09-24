return {
	-- cmdline tools and lsp servers
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"stylua"
			}
		}
	},
    -- bridge betwen mason and lspconfig
    {
        "williamboman/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                "clangd",
                "lua_ls",
                "rust_analyzer"
            }
        },
    },
    -- LSP parser
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        opts = function()
            local ret = {
                diagnostics = {
                    underline = true,
                    update_in_insert = false,
                    virtual_text = {
                        spacing = 4,
                        source = "if_many",
                        prefix = "●"
                    },
                    severity_sort = true,
                    inlay_hints = {
                        enabled = true,
                        exclude = {},
                    },
                    codelens = {
                        enabled = true,
                    },
                    document_highlight = {
                        enabled = true,
                    }
                },
            }
            return ret
        end,
        config = function()
            local lspconfig = require("lspconfig")
            lspconfig.clangd.setup({})
            lspconfig.lua_ls.setup({})
            lspconfig.rust_analyzer.setup({})
        end,
    }
}
