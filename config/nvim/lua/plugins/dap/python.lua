local dap = require("dap")

local M = {}

function M.setup()
	dap.adapters.python = function(cb, config)
		if config.request == "launch" then
			cb({
				type = "executable",
				command = "debugpy-adapter",
				options = { source_filetype = "python" },
			})
		end
	end

	dap.configurations.python = {
		{
			type = "python",
			request = "launch",
			name = "Launch file",
			program = "${file}",
			pythonPath = function()
				local venv = vim.env.VIRTUAL_ENV
				if venv then
					return venv .. "/bin/python3"
				end
				return "python3"
			end,
		},
	}
end

return M
