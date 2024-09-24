return {
    {
        "RRethy/vim-illuminate",
        config = function()
            require("illuminate").configure({
                providers = {
                    "lsp",
                    "treesitter",
                    "regex",
                },
                delay = 100,
                filetype_overrides = {},
            })
        end,
        keys = {
            {
                "<leader>cn",
                function()
                    require("illuminate").goto_next_reference(false)
                end,
                desc = "Goto Next Reference",
            },
            {
                "<leader>cp",
                function()
                    require("illuminate").goto_prev_reference(false)
                end,
                desc = "Goto Previous Reference",
            },
        },
    }
}
