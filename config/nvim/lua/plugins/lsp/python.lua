-- Enable the toolchain
vim.lsp.enable({ "black", "pyright", "ruff" })

local black_config = {}
local pyright_config = {}
local ruff_config = {}

return { black_config, pyright_config, ruff_config }
