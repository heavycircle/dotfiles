local italic_groups = {
	"@comment",
	"@function",
	"@function.builtin",
	"@function.call",
	"@method",
	"@method.call",
}

local function update_hl(group, tbl)
	local old_hl = vim.api.nvim_get_hl_by_name(group, true)
	local new_hl = vim.tbl_extend("force", old_hl, tbl)
	vim.api.nvim_set_hl(0, group, new_hl)
end

-- Make special items italic
local function apply_italics()
	for _, group in ipairs(italic_groups) do
		update_hl(group, { italic = true })
	end

	update_hl("LspInlayHint", { fg = "#585b70", bg = "none", italic = true })
end

apply_italics()
_G.Config.new_autocmd({ "UIEnter", "ColorScheme" }, "*", apply_italics, "Use italics")

-- Flush Floats
_G.Config.new_autocmd({ "UIEnter", "ColorScheme" }, "*", function()
	update_hl("Normal", { bg = "NONE" })
	update_hl("NormalFloat", { link = "Normal" })
	update_hl("FloatBorder", { bg = "NONE" })
end, "Use italics")
