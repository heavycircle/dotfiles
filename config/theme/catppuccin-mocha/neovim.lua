-- Add the plugin
vim.pack.add({
    { src = "https://github.com/catppuccin/nvim" },
})

-- Setup the plugin
require("catppuccin").setup({
    flavour = "mocha",
    transparent_background = false,
    show_end_of_buffer = false,
    term_colors = false,
    styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        functions = {},
        loops = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
    },
    integrations = {
        fzf = true,
        native_lsp = {
            enabled = true,
            virtual_text = {
                errors = { "italic" },
                hints = { "italic" },
                warnings = { "italic" },
                information = { "italic" },
                ok = { "italic" },
            },
            underlines = {
                errors = { "underline" },
                hints = { "underline" },
                warnings = { "underline" },
                information = { "underline" },
                ok = { "underline" },
            },
            inlay_hints = {
                background = true,
            },
        },
    }
})
vim.cmd.colorscheme "catppuccin"
