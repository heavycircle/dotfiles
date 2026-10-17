# sessioneer.wezterm

Workspace switcher for a config-private wezterm setup. Fuses the local
`sessioneer.lua` (zoxide + sshmux) with the UX from 
`MLFlexer/smart_workspace_switcher.wezterm` (active-workspace styling,
events, previous-workspace toggle).

## Load

```lua
package.path = package.path .. ";" .. wezterm.config_dir .. "/?.wezterm/init.lua"
local sessioneer = require("sessioneer")
```