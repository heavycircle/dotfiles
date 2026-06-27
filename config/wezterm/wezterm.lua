local wezterm = require("wezterm")
local config = wezterm.config_builder()
config.automatically_reload_config = true

-- General
config.font_size = 16
config.line_height = 1.2
config.font = wezterm.font("CodeNewRoman Nerd Font")
config.color_scheme = "catppuccin-mocha"

-- Windows
config.window_background_opacity = 0.9
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.macos_window_background_blur = 50

-- Tab Bar
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = false
config_tab_max_width = 32

local colorscheme = wezterm.color.get_builtin_schemes()["catppuccin-mocha"]
config.colors = {
	tab_bar = {
		background = colorscheme.background,
		active_tab = {
			bg_color = colorscheme.background,
			fg_color = colorscheme.selection_fg,
		},
		inactive_tab = {
			bg_color = colorscheme.background,
			fg_color = colorscheme.selection_bg,
		},
		inactive_tab_hover = {
			bg_color = colorscheme.background,
			fg_color = colorscheme.selection_bg,
			underline = "Single",
		},
		new_tab = {
			bg_color = colorscheme.background,
			fg_color = colorscheme.foreground,
		},
		new_tab_hover = {
			bg_color = colorscheme.selection_fg,
			fg_color = colorscheme.foreground,
		},
	},
}

-- Default program
local function fish_path()
	local triple = wezterm.target_triple
	if triple:find("darwin") then
		return "/opt/homebrew/bin/fish"
	else
		return "/usr/bin/fish"
	end
end
config.default_prog = { fish_path(), "-l" }

-- Keybinds
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 2000 }
config.keys = require("keybinds")

-- SSH
config.ssh_domains = require("domains")

return config
