local wezterm = require("wezterm")
local sessioneer = require("sessioneer")

local M = {}

-- Forcing `command.cwd` makes wezterm build a concrete CommandBuilder, whose
-- constructor eagerly snapshots this *local* client process's entire
-- environment (including $HOME) and ships it to wherever the pane spawns.
-- That's a no-op for the local domain (it IS the correct env) but corrupts
-- splits on remote mux domains (e.g. SSHMUX:*), which resolve cwd correctly
-- on their own server-side anyway since source and new pane are on the same
-- remote host. So only override cwd for local-domain splits.
local function split_pane(direction)
	return wezterm.action_callback(function(window, pane)
		if pane:get_domain_name() == "local" then
			local cwd_url = pane:get_current_working_dir()
			local cwd = cwd_url and cwd_url.file_path or nil
			window:perform_action(wezterm.action.SplitPane({ direction = direction, command = { cwd = cwd } }), pane)
		else
			window:perform_action(wezterm.action.SplitPane({ direction = direction }), pane)
		end
	end)
end

M.keys = {
	-- Session Creation
	{ key = "g", mods = "LEADER", action = sessioneer.project_select() },
	{ key = "G", mods = "LEADER|SHIFT", action = sessioneer.ssh_select() },
	-- Session Navigation
	{ key = "(", mods = "LEADER|SHIFT", action = wezterm.action.SwitchWorkspaceRelative(-1) },
	{ key = ")", mods = "LEADER|SHIFT", action = wezterm.action.SwitchWorkspaceRelative(1) },
	{ key = "s", mods = "LEADER", action = wezterm.action.ShowLauncherArgs({ flags = "WORKSPACES" }) },
	-- Window Creation
	{ key = "c", mods = "LEADER", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
	{ key = "X", mods = "LEADER|SHIFT", action = wezterm.action.CloseCurrentTab({ confirm = false }) },
	-- Window Navigation
	{ key = "n", mods = "LEADER", action = wezterm.action.ActivateTabRelative(1) },
	{ key = "p", mods = "LEADER", action = wezterm.action.ActivateTabRelative(-1) },
	-- Pane Creation
	{ key = "%", mods = "LEADER|SHIFT", action = split_pane("Right") },
	{ key = '"', mods = "LEADER|SHIFT", action = split_pane("Down") },
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
