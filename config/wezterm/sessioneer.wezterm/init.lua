local wezterm = require("wezterm")
local act = wezterm.action
local mux = wezterm.mux

local M = {}

local function run(argv)
	local success, ok, stdout, stderr = pcall(wezterm.run_child_process, argv)
	if not success then
		wezterm.log_error("sessioneer: " .. table.concat(argv, " ") .. ": " .. tostring(ok))
		return ""
	end
	if not ok then
		wezterm.log_error("sessioneer: " .. table.concat(argv, " ") .. ": " .. (stderr or ""))
		return ""
	end
	return stdout
end

-- TODO: Add Windows Equivalent (?)
-- GUI launches (macOS launchd especially) don't inherit the login shell's PATH, so ask the shell.
function M.get_path(bin)
	local key = "sessioneer_path_" .. bin
	if not wezterm.GLOBAL[key] then
		local path = run({ os.getenv("SHELL") or "/bin/sh", "-lc", "command -v " .. bin }):gsub("%s+$", "")
		if path == "" then
			return bin
		end
		wezterm.GLOBAL[key] = path
	end
	return wezterm.GLOBAL[key]
end

M.config = {
	format = {
		current = { { Foreground = { AnsiColor = "Fuchsia" } }, { Attribute = { Intensity = "Bold" } } },
		active = { { Foreground = { AnsiColor = "Green" } } },
		candidate = {},
	},
	glyph = { current = "● ", active = "○ ", candidate = "  " },
}

function M.setup(opts)
	for k, v in pairs(opts or {}) do
		M.config[k] = v
	end
end

-- Format names of items in <leader>-g display.
local function fmt(style, glyph, text)
	local items = {}
	for _, a in ipairs(style) do
		items[#items + 1] = a
	end
	items[#items + 1] = { Text = glyph .. text }
	return wezterm.format(items)
end

local function workspace_set()
	local set = {}
	for _, name in pairs(mux.get_workspace_names()) do
		set[name] = true
	end
	return set
end

-- Run zoxide on the local or remote host.
local function zoxide_argv(domain, ...)
	local argv = domain == "local" and { M.config.zoxide_path or M.get_path("zoxide") }
		or { "ssh", (domain:gsub("^SSHMUX:", "")), "zoxide" }
	for _, arg in ipairs({ ... }) do
		argv[#argv + 1] = arg
	end
	return argv
end

function M.get_project_choices(pane)
	local domain = pane:get_domain_name()
	local current = mux.get_active_workspace()
	local existing = workspace_set()
	local choices = {
		{ id = current, label = fmt(M.config.format.current, M.config.glyph.current, current) },
	}

	for _, name in ipairs(mux.get_workspace_names()) do
		if name ~= current then
			choices[#choices + 1] = {
				id = name,
				label = fmt(M.config.format.active, M.config.glyph.active, name),
			}
		end
	end

	for _, path in ipairs(wezterm.split_by_newlines(run(zoxide_argv(domain, "query", "-l")))) do
		local name = path:gsub("^" .. wezterm.home_dir, "~")
		if not existing[name] then
			choices[#choices + 1] = {
				id = path,
				label = fmt(M.config.format.candidate, M.config.glyph.candidate, name),
			}
		end
	end

	return choices, domain
end

local function shell_quote(s)
	return "'" .. s:gsub("'", "'\\''") .. "'"
end

-- Switch to a new pane, emitting a sessioneer.leaving event.
local function switch(window, pane, name, spawn)
	local prev = window:active_workspace()
	wezterm.GLOBAL.sessioneer_prev = prev
	wezterm.emit("sessioneer.leaving", window, prev)
	window:perform_action(act.SwitchToWorkspace({ name = name, spawn = spawn }), pane)
end

-- Expose switch for other modules (e.g. resurrect restore) so <leader>s keeps working.
M.switch = switch

-- Select a project workspace.
function M.project_select()
	return wezterm.action_callback(function(window, pane)
		local choices, domain = M.get_project_choices(pane)
		window:perform_action(
			act.InputSelector({
				title = "Choose Workspace",
				fuzzy = true,
				fuzzy_description = "Workspace: ",
				choices = choices,
				action = wezterm.action_callback(function(iw, ip, id, _label)
					if not id then
						return
					end

					local existing = workspace_set()
					if existing[id] then
						switch(iw, ip, id, nil)
						wezterm.emit("sessioneer.chosen", iw, id)
					else
						local name = id:gsub("^" .. wezterm.home_dir, "~")
						if domain == "local" then
							switch(iw, ip, name, { cwd = id, domain = "DefaultDomain" })
						else
							-- A cwd/args spawn ships this machine's env (HOME, SHELL, PATH) to the remote mux.
							local _, remote_pane = mux.spawn_window({ workspace = name, domain = { DomainName = domain } })
							remote_pane:send_text(" cd " .. shell_quote(id) .. " && clear\n")
							switch(iw, ip, name, nil)
						end
						wezterm.emit("sessioneer.created", iw, name, id)
						run(zoxide_argv(domain, "add", id))
					end
				end),
			}),
			pane
		)
	end)
end

-- SSH-select a SSHMUX connection.
function M.ssh_select()
	return wezterm.action_callback(function(window, pane)
		local choices = {}
		-- FIXME: Repeated code?
		for _, dom in ipairs(wezterm.default_ssh_domains()) do
			if dom.name:match("^SSHMUX:") then
				choices[#choices + 1] = { id = dom.name, label = dom.name:gsub("^SSHMUX:", "") }
			end
		end

		window:perform_action(
			act.InputSelector({
				title = "Choose SSH Host",
				fuzzy = true,
				choices = choices,
				action = wezterm.action_callback(function(_iw, _ip, id, label)
					if not id then
						return
					end

					-- HWIL Connection Point (if applicable) --
					wezterm.emit("sessioneer.ssh.connecting", id, label)
					wezterm.background_child_process({ wezterm.executable_dir .. "/wezterm", "connect", id })
				end),
			}),
			pane
		)
	end)
end

-- Endpoint to switch to the previous workspace
function M.switch_to_prev()
	return wezterm.action_callback(function(window, pane)
		local prev = wezterm.GLOBAL.sessioneer_prev
		if not prev or prev == window:active_workspace() or not workspace_set()[prev] then
			return
		end

		switch(window, pane, prev, nil)
		wezterm.emit("sessioneer.chosen", window, prev)
	end)
end

-- Switch to a relative workspace, recording the previous one for switch_to_prev
function M.switch_relative(offset)
	return wezterm.action_callback(function(window, pane)
		local prev = window:active_workspace()
		wezterm.GLOBAL.sessioneer_prev = prev
		wezterm.emit("sessioneer.leaving", window, prev)
		window:perform_action(act.SwitchWorkspaceRelative(offset), pane)
	end)
end

return M
