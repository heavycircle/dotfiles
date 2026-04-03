-- Big enough to get its own config

require("mini.basics").setup({
	options = { basic = false },
	mappings = { windows = true, move_with_alt = true },
	autocommands = { relnum_in_visual_mode = true },
})

require("mini.extra").setup()

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

require("mini.notify").setup({
	window = {
		winblend = vim.o.winblend,
	},
})

require("mini.icons").setup()
MiniIcons.mock_nvim_web_devicons()
MiniIcons.tweak_lsp_kind()

require("mini.ai").setup()
require("mini.indentscope").setup()
require("mini.tabline").setup()
require("mini.pairs").setup({ modes = { insert = true, command = true, terminal = false } })
require("mini.surround").setup()
require("mini.visits").setup()
