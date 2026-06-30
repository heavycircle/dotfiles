local wezterm = require("wezterm")
local sessioneer = require("sessioneer")

local M = {}

M.keys = {
	-- Session Creation
	{ key = "g", mods = "LEADER", action = sessioneer.project_select() },
	{ key = "G", mods = "LEADER|SHIFT", action = sessioneer.ssh_select() },
	-- Session Navigation
	{ key = "(", mods = "LEADER|SHIFT", action = wezterm.action.SwitchWorkspaceRelative(-1) },
	{ key = ")", mods = "LEADER|SHIFT", action = wezterm.action.SwitchWorkspaceRelative(1) },
	{ key = "s", mods = "LEADER", action = wezterm.action.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }) },
	-- Window Creation
	{ key = "c", mods = "LEADER", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
	{ key = "X", mods = "LEADER|SHIFT", action = wezterm.action.CloseCurrentTab({ confirm = false }) },
	-- Window Navigation
	{ key = "n", mods = "LEADER", action = wezterm.action.ActivateTabRelative(1) },
	{ key = "p", mods = "LEADER", action = wezterm.action.ActivateTabRelative(-1) },
	-- Pane Creation
	{ key = "%", mods = "LEADER|SHIFT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = '"', mods = "LEADER|SHIFT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "x", mods = "LEADER", action = wezterm.action.CloseCurrentPane({ confirm = false }) },
	-- Pane Navigation
	{ key = "h", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Left") },
	{ key = "j", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Down") },
	{ key = "k", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Up") },
	{ key = "l", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Right") },
	-- Search
	{ key = "/", mods = "LEADER", action = wezterm.action.Search({ CaseInSensitiveString = "" }) },
	{ key = "[", mods = "LEADER", action = wezterm.action.ActivateCopyMode },
}

M.setup = function()
	local keys = M.keys

	for i = 1, 8 do
		table.insert(keys, {
			key = tostring(i),
			mods = "LEADER",
			action = wezterm.action.ActivateTab(i - 1),
		})
	end

	return keys
end

return M
