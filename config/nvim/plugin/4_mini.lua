-- Big enough to get its own config

local now, later = MiniDeps.now, MiniDeps.later
local now_if_args = _G.Config.now_if_args

now(function()
	require("mini.basics").setup({
		options = { basic = false },
		mappings = { windows = true, move_with_alt = true },
		autocommands = { relnum_in_visual_mode = true },
	})
end)

later(function()
	require("mini.extra").setup()
end)

now(function()
	require("mini.icons").setup()

	later(MiniIcons.mock_nvim_web_devicons)
	later(MiniIcons.tweak_lsp_kind)
end)

later(function()
	local hipatterns = require("mini.hipatterns")
	local hi_words = MiniExtra.gen_highlighter.words
	hipatterns.setup({
		highlighters = {
			fixme = hi_words({ "FIXME", "Fixme", "fixme" }, "MiniHipatternsFixme"),
			hack = hi_words({ "HACK", "Hack", "hack" }, "MiniHipatternsHack"),
			todo = hi_words({ "TODO", "Todo", "todo" }, "MiniHipatternsTodo"),
			note = hi_words({ "NOTE", "Note", "note" }, "MiniHipatternsNote"),

			hex_color = hipatterns.gen_highlighter.hex_color(),
		},
	})
end)

later(function()
	require("mini.ai").setup()
end)

later(function()
	require("mini.bracketed").setup() -- TODO: Should remove in nvim 0.12.0
end)

later(function()
	require("mini.comment").setup() -- TODO: Should remove in nvim 0.12.0
end)

later(function()
	require("mini.indentscope").setup()
end)

later(function()
	require("mini.notify").setup()
end)

later(function()
	require("mini.pairs").setup({ modes = { insert = true, command = true, terminal = false } })
end)

later(function()
	require("mini.pick").setup()
end)

later(function()
	require("mini.surround").setup()
end)

later(function()
	require("mini.visits").setup()
end)
