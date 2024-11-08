return {
  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "ninja", "rst" } },
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")

      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "pylsp" },
      })

      lspconfig.pylsp.setup({ capabilities = capabilities })
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
        },
      },
    },
  },

  -- DAP
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      "mfussenegger/nvim-dap-python",
    },
  },

  -- Formatting and Linting
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "jay-babu/mason-null-ls.nvim",
    },
    config = function(_, opts)
      require("mason").setup()
      require("mason-null-ls").setup({
        ensure_installed = { "black", "flake8" },
      })

      local null_ls = require("null-ls")
      null_ls.setup({
        sources = vim.tbl_deep_extend("force", opts.sources or {}, {
            null_ls.builtins.formatting.black
        }),
      })
    end,
  },
}
