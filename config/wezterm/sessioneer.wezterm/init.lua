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

-- The workspace this GUI window belongs to. window:active_workspace() is the
-- GUI process's active workspace, which can disagree with the window's own
-- (notably in `wezterm connect` windows), breaking prev/current comparisons.
local function current_workspace(window)
	local mux_win = window:mux_window()
	return mux_win and mux_win:get_workspace() or window:active_workspace()
end

local function workspace_set()
	local set = {}
	for _, name in pairs(mux.get_workspace_names()) do
		set[name] = true
	end
	return set
end

-- Run zoxide on the local or remote host. Remote calls reuse one multiplexed
-- OpenSSH connection, so you authenticate once per ControlPersist window
-- instead of on every <leader>g (wezterm's own SSH session can't be reused).
local function zoxide_argv(domain, ...)
	local argv = domain == "local" and { M.config.zoxide_path or M.get_path("zoxide") }
		or {
			"ssh",
			"-o", "ControlMaster=auto",
			"-o", "ControlPath=~/.ssh/sessioneer-%C",
			"-o", "ControlPersist=30m",
			(domain:gsub("^SSHMUX:", "")),
			"zoxide",
		}
	for _, arg in ipairs({ ... }) do
		argv[#argv + 1] = arg
	end
	return argv
end

function M.get_project_choices(window, pane)
	local domain = pane:get_domain_name()
	local current = current_workspace(window)
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
-- Handlers of sessioneer.leaving run synchronously; an error in one must not
-- abort the switch (this is what made <leader>s / <leader>g flaky).
local function emit_leaving(window, prev)
	local ok, err = pcall(wezterm.emit, "sessioneer.leaving", window, prev)
	if not ok then
		wezterm.log_error("sessioneer: sessioneer.leaving handler failed: " .. tostring(err))
	end
end

local function switch(window, pane, name, spawn)
	local prev = current_workspace(window)
	wezterm.GLOBAL.sessioneer_prev = prev
	emit_leaving(window, prev)
	window:perform_action(act.SwitchToWorkspace({ name = name, spawn = spawn }), pane)
end

-- Expose switch for other modules (e.g. resurrect restore) so <leader>s keeps working.
M.switch = switch

-- Select a project workspace.
function M.project_select()
	return wezterm.action_callback(function(window, pane)
		local choices, domain = M.get_project_choices(window, pane)
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
							local _, remote_pane, remote_win = mux.spawn_window({ workspace = name, domain = { DomainName = domain } })
							-- wezterm bug: the remote mux files the new window under this
							-- client's *current* workspace, not `name` (only the local copy
							-- gets `name`). Re-assert it so the server is told; setting the
							-- same value is a no-op, hence the detour via a temp name.
							remote_win:set_workspace(name .. ".sessioneer-sync")
							remote_win:set_workspace(name)
							remote_pane:send_text(" cd " .. shell_quote(id) .. " && clear\n")
							switch(iw, ip, name, nil)
						end
						wezterm.emit("sessioneer.created", iw, name, id)
						-- Fire-and-forget: don't block the GUI on a second round-trip.
						wezterm.background_child_process(zoxide_argv(domain, "add", id))
					end
				end),
			}),
			pane
		)
	end)
end

-- `wezterm connect` in the background. Its window vanishes on failure and the
-- error only goes to stderr, so on a non-zero exit show the ERROR lines (or
-- the tail of stderr) in a dialog that stays until dismissed.
-- sh args: $0 = wezterm binary, $1 = domain id.
local connect_script = [=[
err=$("$0" connect "$1" 2>&1 >/dev/null); rc=$?
[ "$rc" -eq 0 ] && exit 0
msg=$(printf '%s\n' "$err" | grep 'ERROR' | tail -n 20)
[ -n "$msg" ] || msg=$(printf '%s\n' "$err" | tail -n 20)
[ -n "$msg" ] || msg="exited with status $rc"
title="wezterm connect $1 failed"
if command -v kdialog >/dev/null 2>&1; then
	kdialog --title "$title" --error "$msg"
elif command -v osascript >/dev/null 2>&1; then
	osascript -e 'on run argv' \
		-e 'display dialog (item 2 of argv) with title (item 1 of argv) buttons {"OK"} with icon stop' \
		-e 'end run' "$title" "$msg"
elif command -v notify-send >/dev/null 2>&1; then
	notify-send --app-name=WezTerm --urgency=critical "$title" "$msg"
fi
]=]

local function connect(id)
	wezterm.background_child_process({
		"sh", "-c", connect_script, wezterm.executable_dir .. "/wezterm", id,
	})
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

					-- Each `wezterm connect` is its own GUI process with its own
					-- active workspace, so connecting again to an already-connected
					-- host gives another window that can show a different remote
					-- workspace. It opens on the first non-empty workspace; <leader>g
					-- away from it.
					wezterm.emit("sessioneer.ssh.connecting", id, label)
					connect(id)
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
		if not prev or prev == current_workspace(window) or not workspace_set()[prev] then
			return
		end

		switch(window, pane, prev, nil)
		wezterm.emit("sessioneer.chosen", window, prev)
	end)
end

-- Switch to a relative workspace, recording the previous one for switch_to_prev
function M.switch_relative(offset)
	return wezterm.action_callback(function(window, pane)
		local prev = current_workspace(window)
		wezterm.GLOBAL.sessioneer_prev = prev
		emit_leaving(window, prev)
		window:perform_action(act.SwitchWorkspaceRelative(offset), pane)
	end)
end

return M
