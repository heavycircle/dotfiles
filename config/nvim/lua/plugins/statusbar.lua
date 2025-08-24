-- Use lualine for the statusbar.
--
-- It's easy to configure, and easy enough for me to use my custom colorscheme with it.

local M = {}

function M.install()
    vim.pack.add({
        { src = "https://github.com/nvim-tree/nvim-web-devicons" },
        { src = "https://github.com/nvim-lualine/lualine.nvim" }
    })
end

function M.setup()
    M.install()

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
end

return M
