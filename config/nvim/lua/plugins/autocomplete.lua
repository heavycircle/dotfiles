local M = {}

function M.install()
    vim.pack.add({
        { src = "https://github.com/saghen/blink.cmp", version = "main", build = "cargo build --release" },
    })
end

function M.setup()
    M.install()

    require("blink.cmp").setup({
        keymap = {
            preset = "default",
            ["<Up>"] = { "select_prev", "fallback" },
            ["<Down>"] = { "select_next", "fallback" },
            ["<C-e>"] = { "accept" },
        },
        appearance = { nerd_font_variant = "normal" },
        completion = {
            accept = {
                auto_brackets = { enabled = true },
            },
            menu = {
                draw = { treesitter = { "lsp" } }
            },
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 500
            },
        },
        sources = {
            default = { "lsp", "path", "snippets", "buffer" }
        },
        snippets = { preset = "luasnip" },
        cmdline = { enabled = true },
        fuzzy = { implementation = "prefer_rust" },
    })
end

return M
