-- stylua: ignore start

-- General -----------------------------------------------------

vim.g.mapleader      = " "            -- Space is the leader key

vim.o.mouse          = "a"            -- Enable mouse
vim.o.switchbuf      = "usetab"       -- Use opened buffers when switching

vim.schedule(function() vim.o.clipboard = "unnamedplus" end) -- Use global clipboard

-- UI Changes --------------------------------------------------

vim.o.breakindent    = true                -- Indent wrapped lines to match line start
vim.o.breakindentopt = "list:-1"           -- Add padding for lists
vim.o.colorcolumn    = "+1"                -- Draw column right of max width
vim.o.cursorline     = true                -- Highlight current line
vim.o.laststatus     = 3                   -- The last window gets a status line
vim.o.linebreak      = true                -- Wrap lines at 'breakat'
vim.o.list           = true                -- Show list text indicators
vim.o.number         = true                -- Line numbers
vim.o.numberwidth    = 2                   -- Line column is 2 wide
vim.o.pumheight      = 10                  -- make popups smaller
vim.o.relativenumber = true                -- Relative line numbers
vim.o.ruler          = false               -- Don't show coordinates
vim.o.showmode       = false               -- Don't show mode
vim.o.signcolumn     = "yes"               -- Always show sign column (less movement)
vim.o.splitbelow     = true                -- Split below
vim.o.splitkeep      = "screen"            -- Reduce scroll during split
vim.o.splitright     = true                -- Split right
vim.o.wrap           = false               -- Don't wrap lines

vim.o.cursorlineopt  = "screenline,number" -- Show cursor line per screen line

if vim.fn.has("nvim-0.10") == 0 then
    vim.o.termguicolors = true
end

if vim.fn.has("nvim-0.11") == 1 then
    vim.o.winborder = "bold" -- Show a (round) border
end

if vim.fn.has("nvim-0.12") == 1 then
    vim.o.pummaxwidth     = 100       -- Limit maximum width of popups
    vim.o.completetimeout = 100       -- Time out completions
    vim.o.pumborder       = "rounded" -- Use border in completion
end

-- Editing -----------------------------------------------------

_G.Config.set_indent = function(width)
    vim.opt.shiftwidth  = width -- Use two spaces for indenting
    vim.opt.tabstop     = width -- Show tabs as four spaces
    vim.opt.softtabstop = width
end

_G.Config.set_indent(4)
vim.o.autoindent    = true               -- Enable autoindent
vim.o.expandtab     = true               -- Convert tabs to spaces
vim.o.formatoptions = "rqnl1j"           -- Improve comment editing
vim.o.ignorecase    = true               -- Ignore case during search
vim.o.incsearch     = true               -- Show matches while typing
vim.o.infercase     = true               -- Infer case with built-in completion
vim.o.smartcase     = true               -- Respect case if pattern has uppercase
vim.o.smartindent   = true               -- Smarter indenting
vim.o.spelloptions  = "camel"            -- Treat camelCase as different words
vim.o.virtualedit   = "block"            -- Allow going past line end in block

vim.o.complete      = ".,w,b,kspell"     -- Use less completion sources
vim.o.completeopt   = "menuone,noselect" -- Custom completion options
if vim.fn.has("nvim-0.11") == 1 then
    vim.o.completeopt = "menuone,noselect,fuzzy,nosort"
end

-- Don't put the comment leader when using 'o'.
local format_options = function()
    vim.cmd("setlocal formatoptions-=o")
end
_G.Config.new_autocmd("FileType", "*", format_options, "Proper 'formatoptions'")

-- Diagnostics -------------------------------------------------

vim.highlight.priorities.semantic_tokens = 95 -- Lower than treesitter

-- Don't load on startup
MiniDeps.later(function()
    vim.diagnostic.config({ virtual_text = true })
    vim.lsp.inlay_hint.enable(true)
end)

-- stylua: ignore end
