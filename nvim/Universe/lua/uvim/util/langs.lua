local M = {}

local maps = {
  c = "cpp",
}

function M.install(lang)
  local name = maps[lang] or lang
  local langfile = "uvim.plugins.extras.langs." .. name
  local status, err = pcall(require, langfile)

  if status then
      local reg = require("mason-registry")
      reg.refresh()
    print("Installed " .. name)

  else
    print("Error loading config: ", err)
  end
end

return M
