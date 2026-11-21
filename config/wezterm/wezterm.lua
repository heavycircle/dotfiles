local wezterm = require("wezterm")
package.path = package.path .. ";" .. wezterm.config_dir .. "/?.wezterm/init.lua"
local config = wezterm.config_builder()
config.automatically_reload_config = true

-- Environment
local font_variant = "NF"
local font_size = 16
local theme = "Kanagawa Dragon (Gogh)" -- or "nightfox" or "catppuccin-mocha"

-- General
config.color_scheme = theme
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

-- Colorscheme
local colorscheme = wezterm.color.get_builtin_schemes()[theme]
colorscheme.selection_bg = colorscheme.selection_bg or colorscheme.brights[1]
colorscheme.selection_fg = colorscheme.selection_fg or colorscheme.cursor_bg or colorscheme.foreground

-- Set right status to workspace
wezterm.on("update-right-status", function(window, _pane)
	-- The window's own workspace, not the GUI process's active one (they
	-- differ in `wezterm connect` windows while the remote mux syncs).
	local mux_win = window:mux_window()
	local workspace = mux_win and mux_win:get_workspace() or window:active_workspace()

	window:set_right_status(wezterm.format({
		{ Attribute = { Intensity = "Bold" } },
		{ Foreground = { AnsiColor = "Fuchsia" } },
		{ Text = " ⎋ " .. workspace .. " " },
	}))
end)

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
-- Config reloads re-run this file; only start one timer chain per process.
if not wezterm.GLOBAL.resurrect_periodic_started then
	wezterm.GLOBAL.resurrect_periodic_started = true
	resurrect.periodic_save_all(600)
end
-- Save the workspace being left whenever sessioneer switches away from it.
-- A save failure must never block the switch itself.
wezterm.on("sessioneer.leaving", function(window, workspace)
	local ok, err = pcall(resurrect.save_workspace, workspace)
	if ok then
		require("notify").send(window, "resurrect", "Saved workspace " .. workspace)
	else
		wezterm.log_error("resurrect: saving " .. workspace .. " failed: " .. tostring(err))
	end
end)

-- SSH
config.ssh_domains = wezterm.default_ssh_domains()

return config
