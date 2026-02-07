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
		config.settings.basedpyright.pythonPath = "./.venv/bin/python"
	end,
}
