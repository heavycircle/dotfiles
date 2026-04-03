-- Install mini.nvim first
local path_package = vim.fn.stdpath("data") .. "/site/"
local mini_path = path_package .. "pack/deps/start/mini.nvim"
if not vim.loop.fs_stat(mini_path) then
	vim.cmd('echo "Installing `mini.nvim`" | redraw')
	local clone_cmd = {
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/nvim-mini/mini.nvim",
		mini_path,
	}
	vim.fn.system(clone_cmd)
	vim.cmd("packadd mini.nvim | helptags ALL")
	vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

_G.Config = {}

-- Autocommmand group for our custom commands
local gap_group = vim.api.nvim_create_augroup("gapped", {})

---Wrapper for nvim_create_autocmd to group our local commands.
---@param event string|string[] The event or events to trigger this callback.
---@param pattern string|string[] The pattern(s) to match.
---@param callback fun(args: vim.api.keyset.create_autocmd.callback_args) The function to call on trigger.
---@param desc? string Optional description for the autocommand.
_G.Config.new_autocmd = function(event, pattern, callback, desc)
	local opts = { group = gap_group, pattern = pattern, callback = callback, desc = desc }
	vim.api.nvim_create_autocmd(event, opts)
end
