-- Taken from NvChad (https://github.com/NvChad/ui/blob/v3.0/lua/nvchad/lsp/signature.lua)

local M = {}

local function check_triggeredChars(triggerChars)
	local cur_line = vim.api.nvim_get_current_line()
	local pos = vim.api.nvim_win_get_cursor(0)[2]
	local prev_char = cur_line:sub(pos - 1, pos - 1)
	local cur_char = cur_line:sub(pos, pos)

	for _, char in ipairs(triggerChars) do
		if cur_char == char or prev_char == char then
			return true
		end
	end
end

M.setup = function(client, bufnr)
	local group = vim.api.nvim_create_augroup("LspSignature", { clear = false })
	vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })

	local triggerChars = client.server_capabilities.signatureHelpProvider.triggerCharacters

	vim.api.nvim_create_autocmd("TextChangedI", {
		group = group,
		buffer = bufnr,
		callback = function()
			if check_triggeredChars(triggerChars) then
				vim.lsp.buf.signature_help({ focus = false, silent = true, max_height = 7, border = "single" })
			end
		end,
	})
end

return M
