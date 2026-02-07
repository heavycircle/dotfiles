MiniDeps.add({
	source = "https://github.com/mfussenegger/nvim-dap",
	depends = { "https://github.com/nvim-neotest/nvim-nio" },
})

MiniDeps.add({
	source = "https://github.com/rcarriga/nvim-dap-ui",
	depends = { "https://github.com/theHamsta/nvim-dap-virtual-text" },
})

local dap, dapui = require("dap"), require("dapui")
dap.listeners.before.attach.dapui_config = function()
	dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
	dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
	dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
	dapui.close()
end
dapui.setup({})
