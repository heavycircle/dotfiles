local muted_fg = {
	["catppuccin-mocha"] = "#585b70",
	-- kanagawa reports its name without the variant
	["kanagawa"] = "#625e5a",
}

---Subdued foreground for the active colorscheme, falling back to its Comment color.
---@return string|nil
_G.Config.muted_fg = function()
	if muted_fg[vim.g.colors_name] then
		return muted_fg[vim.g.colors_name]
	end
	local fg = vim.api.nvim_get_hl(0, { name = "Comment", link = false }).fg
	return fg and string.format("#%06x", fg)
end

local function update_hl(group, opts)
	local cur_hl = vim.api.nvim_get_hl(0, { name = group, link = false, create = false })
	local new_hl = vim.tbl_extend("force", cur_hl, opts)
	vim.api.nvim_set_hl(0, group, new_hl)
end

local function apply_overrides()
	-- Make groups transparent
	local transparent_groups = { "Normal", "NormalFloat", "NormalNC", "FloatBorder", "FloatTitle", "Pmenu" }
	for _, group in ipairs(transparent_groups) do
		update_hl(group, { bg = "NONE" })
	end

	-- Fix link tweaks
	vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
	vim.api.nvim_set_hl(0, "NormalNC", { link = "Normal" })

	-- Fix italics
	local italic_groups = { "@comment", "@function", "@method" }
	for _, group in ipairs(italic_groups) do
		update_hl(group, { italic = true })
	end

	-- Manually override LspInlayHint
	vim.api.nvim_set_hl(0, "LspInlayHint", { fg = Config.muted_fg(), bg = "NONE", italic = true })
end

-- Make the autocommand
local augroup = vim.api.nvim_create_augroup("ThemeOverride", { clear = true })
vim.api.nvim_create_autocmd({ "UiEnter", "ColorScheme" }, {
	group = augroup,
	pattern = "*",
	callback = apply_overrides,
})
