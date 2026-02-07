-- Taken from NvChad (https://github.com/NvChad/ui/blob/v3.0/lua/nvchad/lsp/renamer.lua)

local lsp = vim.lsp
local api = vim.api

local function get_text_at_range(range, position_encoding)
	return api.nvim_buf_get_text(
		0,
		range.start.line,
		lsp.util._get_line_byte_from_position(0, range.start, position_encoding),
		range["end"].line,
		lsp.util._get_line_byte_from_position(0, range["end"], position_encoding),
		{}
	)[1]
end

local function get_symbol_to_rename(cb)
	local cword = vim.fn.expand("<cword>")
	local clients = lsp.get_clients({ bufnr = 0, method = "textDocument/rename" })

	if #clients == 0 then
		cb(cword)
		return
	end

	-- Prefer clients that support prepareRename
	table.sort(clients, function(a, b)
		return a:supports_method("textDocument/prepareRename") and not b:supports_method("textDocument/prepareRename")
	end)

	local client = clients[1]

	if client:supports_method("textDocument/prepareRename") then
		local params = lsp.util.make_position_params(0, client.offset_encoding)

		client:request("textDocument/prepareRename", params, function(err, result, _, _)
			if err or not result then
				cb(cword)
			end

			local symbol_text = cword

			if result.placeholder then
				symbol_text = result.placeholder
			elseif result.start then
				symbol_text = get_text_at_range(result, client.offset_encoding)
			elseif result.range then
				symbol_text = get_text_at_range(result.range, client.offset_encoding)
			end

			cb(symbol_text)
		end, 0)
	else
		cb(cword)
	end
end

return function()
	local popup = require("gapped.utils.popup")
	get_symbol_to_rename(function(to_rename)
		popup.show({
			title = " Rename Symbol ",
			body = " " .. to_rename,
			callback = function(newName)
				if #newName > 0 and newName ~= to_rename then
					local params = vim.lsp.util.make_position_params(0, "utf-8")
					params.newName = newName
					vim.lsp.buf_request(0, "textDocument/rename", params)
				end
			end,
		})
	end)
end
