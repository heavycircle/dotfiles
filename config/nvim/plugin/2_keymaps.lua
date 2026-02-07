-- QoL Keymaps -------------------------------------------------

-- Keep cursor positioning when using J and K
vim.keymap.set("n", "J", "mzJ`z")

-- Keep cursor mid-page when page up/down
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Keep cursor mid-page when searching
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "n", "nzzzv")

-- Better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Don't put 'x' deletes in keyboard
vim.keymap.set("n", "x", '"_x')

-- Slide lines up and down
vim.keymap.set("v", "J", ":m >+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m <-2<CR>gv=gv")

-- Keep clipboard when pasting with <leader>
vim.keymap.set("x", "<leader>p", '"_dp')
vim.keymap.set({ "x", "v" }, "<leader>d", '"_d')

-- Accepting autocomplete
vim.keymap.set("i", "<C-Space>", "<C-x><C-o>", { noremap = true })
vim.keymap.set("i", "<C-e>", "<C-e>", { noremap = true })

-- Leader Keymaps ----------------------------------------------

local map_normal = function(suffix, cmd, desc)
	vim.keymap.set("n", "<leader>" .. suffix, cmd, { desc = desc })
end

local new_scratch = function()
	vim.api.nvim_win_set_buf(0, vim.api.nvim_create_buf(true, true))
end

local toggle_inlay_hints = function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end

-- b: Buffer
map_normal("bs", new_scratch, "Scratch Buffer")

-- c: Code
map_normal("ca", "<CMD>lua vim.lsp.buf.code_action()<CR>", "LSP: Code Actions")
map_normal("cd", "<CMD>lua vim.lsp.buf.definition()<CR>", "LSP: Goto Implementation")
map_normal("cD", "<CMD>lua vim.lsp.buf.implementation()<CR>", "LSP: Goto Definition")
map_normal("cf", "<CMD>lua require('conform').format()<CR>", "LSP: Format")
map_normal("cg", "<CMD>lua require('neogen').generate()<CR>", "LSP: Generate Comment")
map_normal("ci", "<CMD>lua vim.lsp.buf.incoming_calls()<CR>", "LSP: Incoming Calls")
map_normal("co", "<CMD>lua vim.lsp.buf.outgoing_calls()<CR>", "LSP: Outgoing Calls")
map_normal("cq", toggle_inlay_hints, "LSP: Toggle Inlay Hints")
map_normal("cr", "<CMD>lua vim.lsp.buf.references()<CR>", "LSP: References")
map_normal("cR", "<CMD>lua vim.lsp.buf.rename()<CR>", "LSP: Rename")
map_normal("cs", "<CMD>lua vim.lsp.buf.document_symbol()<CR>", "LSP: Document Symbols")
map_normal("cS", "<CMD>lua vim.lsp.buf.workspace_symbol()<CR>", "LSP: Workspace Symbols")
map_normal("ct", "<CMD>lua vim.lsp.buf.type_definition()<CR>", "LSP: Type Definition")
map_normal("cx", "<CMD>lua vim.diagnostic.open_float()<CR>", "LSP: Diagnostics")

-- d: Debug
map_normal("dB", "<CMD>lua require('dap').toggle_breakpoint()<CR>", "DAP: Toggle Breakpoint")
map_normal("dc", "<CMD>lua require('dap').continue()<CR>", "DAP: Run/Continue")
map_normal("dC", "<CMD>lua require('dap').run_to_cursor()<CR>", "DAP: Run to Cursor")
map_normal("de", "<CMD>lua require('dapui').eval()<CR>", "DAP: Eval")
map_normal("dg", "<CMD>lua require('dap').goto_()<CR>", "DAP: Go to Line")
map_normal("di", "<CMD>lua require('dap').step_into()<CR>", "DAP: Step Into")
map_normal("dj", "<CMD>lua require('dap').down()<CR>", "DAP: Down")
map_normal("dk", "<CMD>lua require('dap').up()<CR>", "DAP: Up")
map_normal("dl", "<CMD>lua require('dap').run_last()<CR>", "DAP: Run Last")
map_normal("do", "<CMD>lua require('dap').step_out()<CR>", "DAP: Step Out")
map_normal("dO", "<CMD>lua require('dap').step_over()<CR>", "DAP: Step Over")
map_normal("dP", "<CMD>lua require('dap').pause()<CR>", "DAP: Pause")
map_normal("dr", "<CMD>lua require('dap').repl.toggle()<CR>", "DAP: Toggle REPL")
map_normal("ds", "<CMD>lua require('dap').session()<CR>", "DAP: Session")
map_normal("dt", "<CMD>lua require('dap').terminate()<CR>", "DAP: Terminate")
map_normal("dw", "<CMD>lua require('dap.ui.widgets').hover()<CR>", "DAP: Widgets")
map_normal("du", "<CMD>lua require('dapui').toggle()<CR>", "DAP: Toggle UI")

-- e: Explorer
map_normal("e", "<CMD>lua require('oil').open_float()<CR>", "Explorer")

-- f: Find
map_normal("fc", "<CMD>Pick git_branches<CR>", "Find: Branches")
map_normal("fc", "<CMD>Pick git_commits<CR>", "Find: Commits (all)")
map_normal("fC", "<CMD>Pick git_commits path='%'<CR>", "Find: Commits (buffer)")
map_normal("ff", "<CMD>Pick files<CR>", "Find: Files")
map_normal("fg", "<CMD>Pick grep_live<CR>", "Find: Grep String")
map_normal("fG", "<CMD>Pick grep pattern='<cword>'<CR>", "Find: Grep Word")
map_normal("fh", "<CMD>Pick help<CR>", "Find: Files")
map_normal("fk", "<CMD>Pick keymaps<CR>", "Find: Keymaps")
map_normal("fl", "<CMD>Pick visit_labels cwd=''<CR>", "Find: Visit Labels (all)")
map_normal("fL", "<CMD>Pick visit_labels<CR>", "Find: Visit Labels (cwd)")
map_normal("fm", "<CMD>Pick manpages<CR>", "Find: Man Pages")
map_normal("fp", "<CMD>Pick projects<CR>", "Find: Projects")
map_normal("fr", "<CMD>Pick resume<CR>", "Find: Resume")
map_normal("fv", "<CMD>Pick visit_paths cwd=''<CR>", "Find: Visit Paths (all)")
map_normal("fV", "<CMD>Pick visit_paths<CR>", "Find: Visit Paths (cwd)")

map_normal("vv", "<CMD>lua MiniVisits.add_label('core')<CR>", "Visits: Add Core Label")
map_normal("vV", "<CMD>lua MiniVisits.remove_label('core')<CR>", "Visits: Remove Core Label")
map_normal("vl", "<CMD>lua MiniVisits.add_label()<CR>", "Visits: Add Label")
map_normal("vL", "<CMD>lua MiniVisits.remove_label()<CR>", "Visits: Remove Label")
