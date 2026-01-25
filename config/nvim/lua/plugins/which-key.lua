local M = {}

function M.install()
	vim.pack.add({
		{ src = "https://github.com/folke/which-key.nvim" },
	})
end

function M.setup()
	M.install()

    -- stylua: ignore start
    vim.keymap.set("n", "<leader>/", function() require("which-key").show({ global = false }) end,
        { desc = "Local Keymaps" })
    vim.keymap.set("n", "<leader>?", function() require("which-key").show({ global = true }) end,
        { desc = "Global Keymaps" })
	-- stylua: ignore end
end

return M
