return {
    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        opts = { ensure_installed = { "ninja", "rst" } }
    },
    -- LSP
    {
        "neovim/nvim-lspconfig",
        opts = function(_, opts)
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local lspconfig = require "lspconfig"

            lspconfig.pylsp.setup { capabilities = capabilities }
        end,
    },
    -- NeoTest
    {
        "nvim-neotest/neotest",
        optional = true,
        dependencies = { "nvim-neotest/neotest-python" },
        opts = {
            adapters = {
                ["neotest-python"] = {
                    runner = "pytest",
                    python = ".venv/bin/python",
                }
            }
        }
    },
    -- DAP
    {
        "mfussenegger/nvim-dap",
        optional = true,
        dependencies = {
            "mfussenegger/nvim-dap-python",
        }
    },
    -- Autocomplete
    {
        "hrsh7th/nvim-cmp",
        optional = true,
        opts = function(_, opts)
            opts.auto_brackets = opts.auto_brackets or {}
            table.insert(opts.auto_brackets, "python")
        end,
    }
}
