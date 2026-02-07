local has_dap, dap = pcall(require, "dap")
if has_dap then
	dap.configurations.cpp = dap.configurations.c
end
