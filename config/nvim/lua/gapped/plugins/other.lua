local hooks = function(ev)
	local name, kind = ev.data.spec.name, ev.data.kind

	if name == "vim-wakatime" and (kind == "install" or kind == "update") then
		vim.cmd("WakaTimeApiKey")
	end
end

vim.api.nvim_create_autocmd("PackChanged", { callback = hooks })
vim.pack.add({ "https://github.com/wakatime/vim-wakatime" })
