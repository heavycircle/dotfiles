MiniDeps.add({
	source = "https://github.com/wakatime/vim-wakatime",
	hooks = {
		post_checkout = function()
			vim.cmd("WakaTimeApiKey")
		end,
	},
})
