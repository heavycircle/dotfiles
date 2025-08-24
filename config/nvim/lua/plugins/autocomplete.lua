-- I'm still iffy on whether I'll keep autocomplete around. I do enjoy my minimal Neovim
-- experience, and continue to argue that autocompletion hogs the screen too much. That
-- being said, it's helpful sometimes.
--
-- I decided to use blink.cmp instead of nvim-cmp this time. LazyVim also switched recently,
-- although it still defaults to nvim-cmp for new users. It's nice that this configuration
-- is much smaller than the old nvim-cmp configuration.

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
            -- Use up and down to get across
            ["<Up>"] = { "select_prev", "fallback" },
            ["<Down>"] = { "select_next", "fallback" },
            -- Accept with CTRL-E
            ["<C-e>"] = { "accept" },
        },
        -- Currently using non-mono NF
        appearance = { nerd_font_variant = "normal" },
        -- Only show documentation when manually triggered
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
        -- Where to get autocompletion
        sources = {
            default = { "lsp", "path", "snippets", "buffer" }
        },
        snippets = { preset = "luasnip" },
        cmdline = { enabled = true },
        fuzzy = { implementation = "prefer_rust" },
    })
end

return M
