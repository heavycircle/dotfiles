return {
	settings = {
		basedpyright = {
			analysis = {
				typeCheckingMode = "strict",
				inlayHints = {
					variableTypes = true,
					functionReturnTypes = true,
				},
			},
		},
	},
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
		local venv_env = ".venv/bin/python"
		if vim.uv.fs_stat(venv_env) then
			config.settings.python.pythonPath = venv_env
			return
		end
	end,
}
