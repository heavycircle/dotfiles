local wezterm = require("wezterm")

local M = {}

-- window:toast_notification works everywhere wezterm has a native
-- backend (Windows, macOS, Linux with a notification daemon). WSLg is
-- the exception: it forwards windows but not D-Bus, so there is no
-- notification daemon. Therefore, we must use powershell.
local toast_script = [=[
[Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null
$t = [Windows.UI.Notifications.ToastNotificationManager]::GetTemplateContent([Windows.UI.Notifications.ToastTemplateType]::ToastText02)
$null = $t.GetElementsByTagName('text').Item(0).AppendChild($t.CreateTextNode(%s))
$null = $t.GetElementsByTagName('text').Item(1).AppendChild($t.CreateTextNode(%s))
[Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier('{1AC14E77-02E7-4E5D-B744-2EB1AE5198B7}\WindowsPowerShell\v1.0\powershell.exe').Show([Windows.UI.Notifications.ToastNotification]::new($t))
]=]

-- PowerShell also treats curly quotes (U+2018-U+201B) as single quotes,
-- so each must be doubled too or a name like "Bob’s" ends the string.
local function ps_quote(s)
	s = tostring(s)
	for _, q in ipairs({ "'", "\u{2018}", "\u{2019}", "\u{201A}", "\u{201B}" }) do
		s = s:gsub(q, q .. q)
	end
	return "'" .. s .. "'"
end

local function is_wsl()
	local f = io.open("/proc/version", "r")
	if not f then
		return false
	end

	local v = f:read("*a") or ""
	f:close()
	return v:lower():find("microsoft", 1, true) ~= nil
end

local wsl = is_wsl()
local linux = wezterm.target_triple:find("linux", 1, true) ~= nil

function M.send(window, title, body)
	if wsl then
		wezterm.background_child_process({
			"powershell.exe",
			"-NoProfile",
			"-NonInteractive",
			"-Command",
			toast_script:format(ps_quote(title), ps_quote(body)),
		})
	elseif linux then
		-- wezterm's own XDG backend doesn't propagate the expire
		-- timeout (notifications on KDE). notify-send does.
		wezterm.background_child_process({
			"notify-send",
			"--app-name=WezTerm",
			"--hint=string:desktop-entry:org.wezfurlong.wezterm",
			"--expire-time=3000",
			title,
			body,
		})
	else
		window:toast_notification(title, body, nil, 3000)
	end
end

return M
