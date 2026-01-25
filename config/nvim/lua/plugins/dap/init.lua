local M = {}

function M.get_langs()
	return { "c", "python" }
end

function M.install()
	vim.pack.add({
		{ src = "https://github.com/mfussenegger/nvim-dap" },
		{ src = "https://github.com/nvim-neotest/nvim-nio" },
		{ src = "https://github.com/theHamsta/nvim-dap-virtual-text" },
		{ src = "https://github.com/rcarriga/nvim-dap-ui" },
	})
end

function M.icons()
	local symbols = {
		DapBreakpoint = { text = "", texthl = "DapBreakpoint", linehl = "", numhl = "" },
		DapBreakpointCondition = { text = "", texthl = "DapBreakpointCondition", linehl = "", numhl = "" },
		DapLogPoint = { text = "", texthl = "DapLogPoint", linehl = "", numhl = "" },
		DapStopped = { text = "", texthl = "DapStopped", linehl = "debugPC", numhl = "Rawfg" },
		DapBreakpointRejected = { text = "", texthl = "DapBreakpointRejected", linehl = "", numhl = "" },
	}

	for name, opts in pairs(symbols) do
		vim.fn.sign_define(name, opts)
	end

	vim.api.nvim_set_hl(0, "DapStopped", { fg = "#9ece6a", bold = true }) -- Green to match Catppuccin 'Success'
	vim.api.nvim_set_hl(0, "debugPC", { bg = "#2e3440" }) -- A subtle background highlight for the line
end

function M.keys()
	local dap, dapui = require("dap"), require("dapui")

    -- stylua: ignore start
    vim.keymap.set("n", "<leader>dB", function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end,
        { desc = "Breakpoint Condition" })
    vim.keymap.set("n", "<leader>db", function() dap.toggle_breakpoint() end, { desc = "Toggle Breakpoint" })
    vim.keymap.set("n", "<leader>dc", function() dap.continue() end, { desc = "Run/Continue" })
    vim.keymap.set("n", "<leader>da", function() dap.continue({ before = get_args }) end, { desc = "Run with Args" })
    vim.keymap.set("n", "<leader>dC", function() dap.run_to_cursor() end, { desc = "Run to Cursor" })
    vim.keymap.set("n", "<leader>dg", function() dap.goto_() end, { desc = "Go to Line (No Execute)" })
    vim.keymap.set("n", "<leader>di", function() dap.step_into() end, { desc = "Step Into" })
    vim.keymap.set("n", "<leader>dj", function() dap.down() end, { desc = "Down" })
    vim.keymap.set("n", "<leader>dk", function() dap.up() end, { desc = "Up" })
    vim.keymap.set("n", "<leader>dl", function() dap.run_last() end, { desc = "Run Last" })
    vim.keymap.set("n", "<leader>do", function() dap.step_out() end, { desc = "Step Out" })
    vim.keymap.set("n", "<leader>dO", function() dap.step_over() end, { desc = "Step Over" })
    vim.keymap.set("n", "<leader>dP", function() dap.pause() end, { desc = "Pause" })
    vim.keymap.set("n", "<leader>dr", function() dap.repl.toggle() end, { desc = "Toggle REPL" })
    vim.keymap.set("n", "<leader>ds", function() dap.session() end, { desc = "Session" })
    vim.keymap.set("n", "<leader>dt", function() dap.terminate() end, { desc = "Terminate" })
    vim.keymap.set("n", "<leader>dw", function() require("dap.ui.widgets").hover() end, { desc = "Widgets" })
    vim.keymap.set("n", "<leader>du", function() dapui.toggle({}) end, { desc = "Dap UI" })
    vim.keymap.set({ "n", "x" }, "<leader>de", function() dapui.eval() end, { desc = "Eval" })
	-- stylua: ignore end
end

function M.setup()
	M.install()

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

	-- Enable our known languages
	local langs = M.get_langs()
	for _, lsp in ipairs(langs) do
		require("plugins.dap." .. lsp).setup()
	end

	M.icons()
	M.keys()
end

return M
