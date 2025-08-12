-- Add the plugin and its dependencies.
vim.pack.add({
    { src = "https://github.com/BurntSushi/ripgrep" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/nvim-telescope/telescope.nvim" },
})

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>,", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>/", builtin.grep_string, { desc = "Grep String" })

-- Code keybinds
vim.keymap.set("n", "<leader>cd", builtin.lsp_implementations, { desc = "Goto Implementation" })
vim.keymap.set("n", "<leader>cD", builtin.lsp_definitions, { desc = "Goto Declaration" })
vim.keymap.set("n", "<leader>ci", builtin.lsp_incoming_calls, { desc = "LSP Incoming Calls" })
vim.keymap.set("n", "<leader>co", builtin.lsp_outgoing_calls, { desc = "LSP Outgoing Calls" })
vim.keymap.set("n", "<leader>cr", builtin.lsp_references, { desc = "LSP References" })
vim.keymap.set("n", "<leader>cs", builtin.lsp_document_symbols, { desc = "[Buffer] LSP Symbols" })
vim.keymap.set("n", "<leader>cS", builtin.lsp_workspace_symbols, { desc = "[Workspace] LSP Symbols" })

-- Find keybinds
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files (cwd)" })

-- Git keybinds
vim.keymap.set("n", "<leader>gb", builtin.git_branches, { desc = "Git Branches" })
vim.keymap.set("n", "<leader>gc", builtin.git_bcommits, { desc = "[Buffer] Git Commits" })
vim.keymap.set("n", "<leader>gC", builtin.git_commits, { desc = "Git Commits" })
vim.keymap.set("n", "<leader>gf", builtin.git_files, { desc = "Git Files" })
vim.keymap.set("n", "<leader>gs", builtin.git_status, { desc = "Git Status" })
vim.keymap.set("n", "<leader>gS", builtin.git_stash, { desc = "Git Stash" })

-- Search keybinds
vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "Live Grep" })
