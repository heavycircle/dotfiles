local wezterm = require("wezterm")

local M = {}

local function get_projects()
	local choices = {}
	local success, stdout, stderr = wezterm.run_child_process({ "zoxide", "query", "-l" })

	if success then
		for line in stdout:gmatch("[^\r\n]+") do
			table.insert(choices, { id = line, label = line })
		end
	end
	return choices
end

local function get_ssh_hosts()
	local choices = {}
	for _, dom in ipairs(wezterm.default_ssh_domains()) do
		if dom.name:match("^SSHMUX:") then
			local host = dom.name:gsub("^SSHMUX:", "")
			table.insert(choices, { id = dom.name, label = host })
		end
	end
	return choices
end

M.project_select = function()
	return wezterm.action_callback(function(window, pane)
		window:perform_action(
			wezterm.action.InputSelector({
				title = "Choose Project",
				choices = get_projects(), -- Runs at keypress time (because of action_callback)
				fuzzy = true,
				action = wezterm.action_callback(function(inner_window, inner_pane, id, label)
					if id then
						inner_window:perform_action(
							wezterm.action.SwitchToWorkspace({
								name = label,
								spawn = { cwd = id },
							}),
							inner_pane
						)
					end
				end),
			}),
			pane
		)
	end)
end

M.ssh_select = function()
	return wezterm.action_callback(function(window, pane)
		window:perform_action(
			wezterm.action.InputSelector({
				title = "Choose SSH Host",
				choices = get_ssh_hosts(),
				fuzzy = true,
				action = wezterm.action_callback(function(inner_window, inner_pane, id, label)
					if not id then
						wezterm.log_info("ssh_select: cancelled")
						return
					end
					wezterm.log_info("ssh_select: attaching domain " .. id)
					inner_window:perform_action(wezterm.action.SwitchToWorkspace({ name = label }), inner_pane)
					inner_window:perform_action(wezterm.action.AttachDomain(id), inner_pane)
				end),
			}),
			pane
		)
	end)
end

return M
