return {
  -- conform.nvim drives formatting code using various formatting platforms.
  -- These are viewed using :ConformInfo but also work inside :Mason.
  {
    "stevearc/conform.nvim",
    opts = {},
  },
  -- none.ls is a reload of null-ls using Neovim as a language server to
  -- inject code actions, diagnostics, and formatting.
  {
    "nvimtools/none-ls.nvim",
    keys = {
      { "<leader>gf", vim.lsp.buf.format, { description = "Format Buffer" } },
    },
  },
}
