return {
	before_init = function(_, config)
		config.settings = config.settings or {}
		config.settings.python = config.settings.python or {}

		-- Check for hatch virtualenv
		local hatch_env = vim.fn.system("hatch env find")
		if vim.v.shell_error == 0 then
			config.settings.python.pythonPath = vim.fn.trim(hatch_env) .. "/bin/python"
			return
		end

		-- Check for .venv virtualenv
		local virtualenv = ".venv/bin/python"
		if vim.uv.fs_stat(virtualenv) then
			config.settings.python.pythonPath = virtualenv
			return
		end
	end,
}
