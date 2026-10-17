local wezterm = require("wezterm")

local here = wezterm.config_dir .. "/resurrect.wezterm"
package.path = package.path .. ";" .. here .. "/plugin/?.lua" .. ";" .. here .. "/plugin/?/init.lua"

local state_manager = require("resurrect.state_manager")
state_manager.change_state_save_dir(here .. "/state/")

local window_state = require("resurrect.window_state")

local M = {
	state_manager = state_manager,
	workspace_state = require("resurrect.workspace_state"),
	window_state = window_state,
	tab_state = require("resurrect.tab_state"),
	fuzzy_loader = require("resurrect.fuzzy_loader"),
}

-- Save one workspace by name (get_workspace_state only handles the active one).
function M.save_workspace(name)
	local state = { workspace = name, window_states = {} }
	for _, mux_win in ipairs(wezterm.mux.all_windows()) do
		if mux_win:get_workspace() == name then
			table.insert(state.window_states, window_state.get_window_state(mux_win))
		end
	end
	if #state.window_states > 0 then
		state_manager.save_state(state)
	end
end

-- Save every workspace; returns how many were saved.
function M.save_all_workspaces()
	local names = wezterm.mux.get_workspace_names()
	for _, name in ipairs(names) do
		M.save_workspace(name)
	end
	return #names
end

-- Like state_manager.periodic_save, but saves all workspaces, not just the active one.
function M.periodic_save_all(interval_seconds)
	wezterm.time.call_after(interval_seconds, function()
		M.save_all_workspaces()
		M.periodic_save_all(interval_seconds)
	end)
end

return M
