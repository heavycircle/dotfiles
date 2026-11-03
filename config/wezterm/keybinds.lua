local wezterm = require("wezterm")
local sessioneer = require("sessioneer")
local resurrect = require("resurrect")
local notify = require("notify")

local M = {}

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
	{ key = "(", mods = "LEADER|SHIFT", action = sessioneer.switch_relative(-1) },
	{ key = ")", mods = "LEADER|SHIFT", action = sessioneer.switch_relative(1) },
	{ key = "s", mods = "LEADER", action = sessioneer.switch_to_prev() },
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
	{ key = "LeftArrow", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Left") },
	{ key = "DownArrow", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Down") },
	{ key = "UpArrow", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Up") },
	{ key = "RightArrow", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Right") },
	-- Pane Resizing
	{ key = "H", mods = "LEADER|SHIFT", action = wezterm.action.AdjustPaneSize({ "Left", 3 }) },
	{ key = "J", mods = "LEADER|SHIFT", action = wezterm.action.AdjustPaneSize({ "Down", 3 }) },
	{ key = "K", mods = "LEADER|SHIFT", action = wezterm.action.AdjustPaneSize({ "Up", 3 }) },
	{ key = "L", mods = "LEADER|SHIFT", action = wezterm.action.AdjustPaneSize({ "Right", 3 }) },
	{ key = "z", mods = "LEADER", action = wezterm.action.TogglePaneZoomState },
	-- Search
	{ key = "/", mods = "LEADER", action = wezterm.action.Search({ CaseInSensitiveString = "" }) },
	{ key = "[", mods = "LEADER", action = wezterm.action.ActivateCopyMode },
	-- resurrect.wezterm
	{
		key = "w",
		mods = "ALT",
		action = wezterm.action_callback(function(win, _pane)
			local name = win:active_workspace()
			resurrect.save_workspace(name)
			notify.send(win, "resurrect", "Saved workspace: " .. name)
		end),
	},
	{
		key = "W",
		mods = "ALT|SHIFT",
		action = wezterm.action_callback(function(win, _pane)
			local n = resurrect.save_all_workspaces()
			notify.send(win, "resurrect", "Saved " .. n .. " workspaces")
		end),
	},
	{
		key = "r",
		mods = "ALT",
		action = wezterm.action_callback(function(win, pane)
			resurrect.fuzzy_loader.fuzzy_load(win, pane, function(id, _label)
				id = string.match(id, "([^/]+)$") -- match after '/'
				id = string.match(id, "(.+)%..+$") -- remove file extension
				local state = resurrect.state_manager.load_state(id, "workspace")
				if not state.workspace then
					return
				end

				local exists = false
				for _, name in ipairs(wezterm.mux.get_workspace_names()) do
					exists = exists or name == state.workspace
				end
				if not exists then
					resurrect.workspace_state.restore_workspace(state, {
						spawn_in_workspace = true,
						relative = true,
						restore_text = true,
						on_pane_restore = resurrect.tab_state.default_on_pane_restore,
					})
				end
				sessioneer.switch(win, pane, state.workspace, nil)
			end, { title = "Restore Workspace", ignore_windows = true, ignore_tabs = true })
		end),
	},
}

function M.setup()
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
