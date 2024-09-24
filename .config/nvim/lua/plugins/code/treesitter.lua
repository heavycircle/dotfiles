local installed = { "bash", "c", "cpp", "diff", "html", "javascript", "json", "latex", "lua", "markdown", "python", "regex", "rust", "typescript", "vim" }

return {
    -- much improved syntax highlighting
    {
        "nvim-treesitter/nvim-treesitter",
        version = false,
        build = ":TSUpdate",
        event = "VeryLazy",
        lazy = vim.fn.argc(-1) == 0,
        init = function(plugin)
            require("lazy.core.loader").add_to_rtp(plugin)
            require("nvim-treesitter.query_predicates")
        end,
        cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
        keys = {
            { "<c-space>", desc = "Increment Selection" },
            { "<bs>", desc = "Decrement Selection", mode = "x" },
        },
        opts_extend = { "ensure_installed" },
        opts = {
            highlight = { enable = true },
            indent = { enable = true },
            ensure_installed = installed,
        },
    },
    -- better text object support (moving, swapping, copying, etc)
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        event = "VeryLazy",
        enabled = true,
    },
    -- automatically add closing tags (html/jsx)
    {
        "windwp/nvim-ts-autotag",
        opts = {},
    },
}
