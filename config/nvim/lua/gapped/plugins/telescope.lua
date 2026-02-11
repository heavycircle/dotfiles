MiniDeps.add({
	source = "https://github.com/nvim-telescope/telescope.nvim",
	depends = { "https://github.com/nvim-lua/plenary.nvim" },
})

-- Conversion of normal vim.o.winblend options. Does not include `shadow`.
local borders = {
	bold = { "━", "┃", "━", "┃", "┏", "┓", "┛", "┗" },
	double = { "═", "║", "═", "║", "╔", "╗", "╝", "╚" },
	none = { "", "", "", "", "", "", "", "" },
	rounded = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
	single = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
	solid = { " ", " ", " ", " ", " ", " ", " ", " " },
}

require("telescope").setup({
	defaults = {
		prompt_prefix = "   ",
		selection_caret = " ",
		entry_prefix = " ",
		sorting_strategy = "ascending",
		layout_config = {
			horizontal = {
				prompt_position = "top",
				preview_width = 0.55,
			},
			width = 0.87,
			height = 0.80,
		},
		borderchars = borders[vim.o.winborder ~= "" and vim.o.winborder or "single"],
		mappings = {
			n = { ["q"] = require("telescope.actions").close },
		},
	},
})

-- Telescope updates winblend automatically but not winborder because it uses borderchars
-- instead of an actual border string. Hopefully they update this in the future.
_G.Config.new_autocmd("OptionSet", "winborder", function()
	require("telescope").setup({
		defaults = { borderchars = borders[vim.v.option_new] },
	})
end, "Update Telescope Border")
