vim.g.mapleader = " "

vim.g.autoformat = true

vim.g.lazyvim_picker = true
vim.g.lazygit_config = true

vim.g.trouble_lualine = true

local opt = vim.opt

opt.autowrite = true
opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"
opt.conceallevel = 2 -- Hide * on markdown for bold/italic, but not markers with substitutions
opt.confirm = true
opt.cursorline = false
opt.expandtab = true
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}
opt.mouse = "a"
opt.laststatus = 3
opt.number = true
opt.pumblend = 10
opt.pumheight = 10
opt.relativenumber = true
opt.scrolloff = 8
opt.showmode = false
opt.shiftwidth = 4
opt.sidescrolloff = 8
opt.smartcase = true
opt.smartindent = true
opt.splitbelow = true
opt.splitright = true
opt.tabstop = 4
opt.termguicolors = true
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200
opt.wildmode = "longest:full,full"
opt.wrap = false

vim.g.markdown_recommended_style = 0

-- line number colors
vim.api.nvim_set_hl(0, 'LineNrAbove', { fg='#D3D3D3' })
vim.api.nvim_set_hl(0, 'LineNrBelow', { fg='#D3D3D3' })
vim.api.nvim_set_hl(0, 'LineNr', { fg='white' })

-- cursorline
vim.api.nvim_set_hl(0, 'CursorLine', { ctermbg = "none", bg = "none" })
