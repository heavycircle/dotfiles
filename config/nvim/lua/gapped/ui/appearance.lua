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
	vim.api.nvim_set_hl(0, "LspInlayHint", { fg = "#585b70", bg = "NONE", italic = true })
end

-- Make the autocommand
local augroup = vim.api.nvim_create_augroup("ThemeOverride", { clear = true })
vim.api.nvim_create_autocmd({ "UiEnter", "ColorScheme" }, {
	group = augroup,
	pattern = "*",
	callback = apply_overrides,
})
