local function build_blink(params)
	vim.notify("Building blink.cmp", vim.log.levels.INFO)
	local obj = vim.system({ "cargo", "build", "--release" }, { cwd = params.path }):wait()
	if obj.code == 0 then
		vim.notify("Building blink.cmp done", vim.log.levels.INFO)
	else
		vim.notify("Building blink.cmp failed", vim.log.levels.ERROR)
	end
end

MiniDeps.add({
	source = "https://github.com/saghen/blink.cmp",
	hooks = { post_install = build_blink, post_checkout = build_blink },
})
require("gapped.plugins.luasnip")

require("blink.cmp").setup({
	keymap = {
		preset = "default",
		["<Up>"] = { "select_prev", "fallback" },
		["<Down>"] = { "select_next", "fallback" },
		["<C-e>"] = { "accept" },
	},
	appearance = { nerd_font_variant = "mono" },
	completion = {
		accept = {
			auto_brackets = { enabled = true },
		},
		menu = {
			border = vim.o.winborder ~= "" and vim.o.winborder or "single",
			winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:BlinkCmpMenuSelection",
			draw = {
				columns = {
					{ "kind_icon" },
					{ "label", "label_description", gap = 1 },
					{ "kind" },
				},
				components = {
					kind_icon = {
						text = function(ctx)
							local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
							return kind_icon .. " "
						end,
						highlight = function(ctx)
							local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
							return hl
						end,
					},
					kind = {
						ellipsis = false,
						width = { fill = true },
						highlight = function(ctx)
							local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
							return hl
						end,
					},
					label = { width = { fill = true, max = 60 } },
					label_description = { width = { max = 60 } },
				},
			},
		},
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 500,
			window = { border = vim.o.winborder ~= "" and vim.o.winborder or "single" },
		},
		ghost_text = { enabled = true },
	},
	signature = { enabled = true, window = { border = vim.o.winborder ~= "" and vim.o.winborder or "single" } },
	sources = { default = { "lsp", "path", "snippets", "buffer" } },
	snippets = { preset = "luasnip" },
})
