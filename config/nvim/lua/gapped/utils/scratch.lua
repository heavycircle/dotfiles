return function()
	local popup = require("gapped.utils.popup")
	popup.show({
		title = " Scratchpad ",
		callback = function(text)
			local file = io.open(vim.fn.expand("~/.cache/nvim/scratch.txt"), "a")
			if file then
				file:write(os.date("%Y-%m-%d %H:%M") .. ": " .. text .. "\n")
				file:close()
				vim.notify("Note saved to scratch.txt")
			end
		end,
	})
end
