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

if vim.fn.has("nvim-0.12") == 0 then
	vim.pack = {}
	vim.pack.add = function(specs, opts)
		specs = vim.tbl_map(function(s)
			return type(s) == "string" and { src = s } or s
		end, specs)
		opts = vim.tbl_extend("force", { load = vim.v.did_init == 1 }, opts or {})

		local cmd_prefix = "packadd" .. (opts.load and "" or "!")
		for _, s in ipairs(specs) do
			local name = s.name or s.src:match("/([^/]+)$")
			vim.cmd(cmd_prefix .. name)
		end
	end
end

-- mini.deps is the backup package manager.
require("mini.deps").setup()

_G.Config = {}

-- Autocommmand group for our custom commands
local gap_group = vim.api.nvim_create_augroup("gapped", {})
_G.Config.new_autocmd = function(event, pattern, callback, desc)
	local opts = { group = gap_group, pattern = pattern, callback = callback, desc = desc }
	vim.api.nvim_create_autocmd(event, opts)
end

-- Add vim.pack.add helper
_G.Config.on_pack_change = function(plugin_name, kinds, callback, desc)
	if vim.fn.has("nvim-0.12") == 0 then
		return
	end
	local f = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if not (name == plugin_name and vim.tbl_contains(kinds, kind)) then
			return
		end
		if not ev.data.active then
			vim.cmd.packadd(plugin_name)
		end
		callback()
	end
	_G.Config.new_autocmd("PackChanged", "*", f, desc)
end

-- Option to load now when nvim has an argument.
-- This assumes that a user wants to edit when you open a file directly.
_G.Config.now_if_args = vim.fn.argc(-1) > 0 and MiniDeps.now or MiniDeps.later
