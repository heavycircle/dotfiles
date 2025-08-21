-- Install lualine
vim.pack.add({
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    { src = "https://github.com/nvim-lualine/lualine.nvim" }
})

-- Setup a statusbar
require("lualine").setup({
    options = {
        globalstatus = true,
        icons_enabled = true,
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { { "branch", icon = "" }, "diff" },
        lualine_c = { { "filename", path = 4 } },
        lualine_x = { { "diagnostics", sources = { "nvim_diagnostic" } }, "lsp_status", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
    },
})
