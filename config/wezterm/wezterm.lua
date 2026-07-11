local wezterm = require("wezterm")
local config = wezterm.config_builder()
config.automatically_reload_config = true

-- General
config.color_scheme = "catppuccin-mocha"
config.enable_wayland = true
config.scrollback_lines = 5000
config.use_dead_keys = false

-- Font
config.font = wezterm.font("Monaspace Argon NF")
config.font_rules = { { italic = true, font = wezterm.font("Monaspace Radon NF") } }
config.font_size = 18
config.line_height = 1.2

-- Windows
config.adjust_window_size_when_changing_font_size = false
config.window_background_opacity = 0.9
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.macos_window_background_blur = 50

-- Set right status to workspace
wezterm.on("update-right-status", function(window, _pane)
	local workspace = window:active_workspace()

	window:set_right_status(wezterm.format({
		{ Attribute = { Intensity = "Bold" } },
		{ Foreground = { AnsiColor = "Fuchsia" } },
		{ Text = " ⎋ " .. workspace .. " " },
	}))
end)

-- Tab Bar
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = false
config.show_new_tab_button_in_tab_bar = false
config.tab_max_width = 32

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
config.keys = require("keybinds").setup()

-- SSH
config.ssh_domains = wezterm.default_ssh_domains()

return config
