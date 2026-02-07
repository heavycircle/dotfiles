MiniDeps.add({ source = "https://github.com/saghen/blink.cmp", checkout = "v1.9.0" })
require("gapped.plugins.luasnip")

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
			border = "rounded",
			winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:BlinkCmpMenuSelection",
			draw = {
				columns = {
					{ "label", "label_description", gap = 1 },
					{ "kind_icon", "kind" },
				},
			},
		},
		documentation = { auto_show = true, auto_show_delay_ms = 500 },
		ghost_text = { enabled = true },
	},
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
		providers = { snippets = { score_offset = 100 } },
	},
	snippets = { preset = "luasnip" },
	signature = { enabled = true },
})
