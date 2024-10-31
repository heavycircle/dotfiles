return {
    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        opts = { ensure_installed = { "lua" } },
    },

    -- LSP
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        opts = function(_, opts)
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local lspconfig = require("lspconfig")

            require("mason").setup()
            require("mason-lspconfig").setuip({
                ensure_installed = { "lua_ls" }
            })

            lspconfig.lua_ls.setup({ capabilities = capabilities })
        end,
    },

    -- Autocomplete
    {
        "hrsh7th/nvim-cmp",
        optional = true,
        opts = function(_, opts)
            opts.auto_brackets = opts.auto_brackets or {}
            table.insert(opts.auto_brackets, "lua")
        end,
    },

    -- Formatting
    {
        "stevearc/conform.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "jay-babu/mason-null-ls.nvim",
            "jose-elias-alvarez/null-ls.nvim",
        },
        opts = function()
            require("mason").setup()
            require("mason-null-ls").setup({
                ensure_installed = { "stylua" }
            })

            local null_ls = require("null-ls")
            null_ls.setup({
                sources = {
                    null_ls.builtins.formatting.stylua
                }
            })
        end,
    },

    -- Linter
    {
        "mfussenegger/nvim-lint",
        dependencies = {
            "williamboman/mason.nvim",
            "jay-babu/mason-null-ls.nvim",
        },
        opts = function()
            require("mason").setup()
            require("mason-null-ls").setup({
                ensure_installed = { "luacheck" },
            })

            local null_ls = require "null-ls"
            null_ls.setup({
                sources = {
                    null_ls.builtins.diagnostics.luacheck,
                }
            })
        end,
    }
}
