-- This abstracts the autocommands, keymaps, and options into separate
-- files so they're easier to find and edit.
-- Autocmds: Changes to different events
-- Keymaps: New key bindins
-- Options: Standard .vimrc changes.
require("config.options")
require("config.keymaps")
require("config.autocmds")

-- Get utility functions
require("util.root")

-- Initiates lazy and tells it to look inside config.plugins for the plugins
-- list. It also checks for plugin updates each time nvim is started.
require("lazy").setup({
	-- {
	--   "nvim-universe/Uvim",
	--   import = "uvim.plugins",
	-- },
	{ import = "plugins" },
	install = { colorscheme = { "catppuccin-mocha" } },
	ui = { backdrop = 100 },
	performance = {
		rtp = {
			disabled_plgins = {
				"netrwPlugin",
			},
		},
	},
})
