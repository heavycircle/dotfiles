local wezterm = require("wezterm")
package.path = package.path .. ";" .. wezterm.config_dir .. "/?.wezterm/init.lua"
local config = wezterm.config_builder()
config.automatically_reload_config = true

-- Environment
local font_variant = "NF"
local font_size = 16
local colorscheme = "Kanagawa Dragon (Gogh)"

-- General
config.color_scheme = colorscheme
config.enable_wayland = false
config.scrollback_lines = 5000
config.use_dead_keys = false

-- Font
config.font = wezterm.font("Monaspace Argon " .. font_variant)
config.font_rules = { { italic = true, font = wezterm.font("Monaspace Radon " .. font_variant) } }
config.font_size = font_size
config.line_height = 1.2

-- Windows
config.adjust_window_size_when_changing_font_size = false
config.window_background_opacity = 0.95
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

local colorscheme = wezterm.color.get_builtin_schemes()[colorscheme]
colorscheme.selection_bg = colorscheme.selection_bg or colorscheme.brights[1]
colorscheme.selection_fg = colorscheme.selection_fg or colorscheme.cursor_bg or colorscheme.foreground

-- Tab Bar
config.use_fancy_tab_bar = true
config.window_frame = {
	font = wezterm.font("Monaspace Argon " .. font_variant, { weight = "Bold" }),
	font_size = font_size,
	active_titlebar_bg = colorscheme.background,
	inactive_titlebar_bg = colorscheme.background,
	button_bg = colorscheme.background,
	button_fg = colorscheme.selection_bg,
	button_hover_bg = colorscheme.selection_bg,
	button_hover_fg = colorscheme.foreground,
}
config.colors = {
	tab_bar = {
		background = colorscheme.background,
		inactive_tab_edge = colorscheme.background,
		active_tab = { bg_color = colorscheme.background, fg_color = colorscheme.selection_fg },
		inactive_tab = { bg_color = colorscheme.background, fg_color = colorscheme.selection_bg },
		inactive_tab_hover = {
			bg_color = colorscheme.background,
			fg_color = colorscheme.selection_bg,
			underline = "Single",
		},
		new_tab = { bg_color = colorscheme.background, fg_color = colorscheme.selection_bg },
		new_tab_hover = { bg_color = colorscheme.background, fg_color = colorscheme.foreground },
	},
}

-- Keybinds
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 2000 }
config.keys = require("keybinds").setup()

-- resurrect.wezterm
local resurrect = require("resurrect")
resurrect.periodic_save_all(600)
-- Save the workspace being left whenever sessioneer switches away from it
wezterm.on("sessioneer.leaving", function(window, workspace)
	resurrect.save_workspace(workspace)
	require("notify").send(window, "resurrect", "Saved workspace " .. workspace)
end)

-- SSH
config.ssh_domains = wezterm.default_ssh_domains()

return config
