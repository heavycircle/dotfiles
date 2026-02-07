local M = {}

--- @param opts table: { title: string, body: string|table, callback: function, buftype: string }
M.show = function(opts)
	local api = vim.api
	local title = opts.title or " Popup "
	local body = opts.body or ""
	local buftype = opts.buftype or "prompt"

	local buf = api.nvim_create_buf(false, true)
	local width = math.max(40, #title + 20)

	local winopts = {
		height = 1,
		style = "minimal",
		border = "rounded", -- Global aesthetic
		row = 1,
		col = 1,
		relative = "cursor",
		width = width,
		title = { { title, "@comment.info" } },
		title_pos = "center",
	}

	local win = api.nvim_open_win(buf, true, winopts)
	vim.wo[win].winhl = "Normal:NormalFloat,FloatBorder:FloatBorder"

	if type(body) == "string" then
		body = { body }
	end
	api.nvim_buf_set_lines(buf, 0, -1, true, body)

	vim.bo[buf].buftype = buftype
	if buftype == "prompt" then
		vim.fn.prompt_setprompt(buf, "❯ ")
		vim.api.nvim_input("A")
	end

	vim.keymap.set({ "i", "n" }, "<Esc>", function()
		if api.nvim_win_is_valid(win) then
			api.nvim_win_close(win, true)
		end
	end, { buffer = buf })

	if opts.callback and buftype == "prompt" then
		vim.fn.prompt_setcallback(buf, function(text)
			if api.nvim_win_is_valid(win) then
				api.nvim_win_close(win, true)
			end
			opts.callback(vim.trim(text))
		end)
	end

	return buf, win
end

return M
