-- Add plugins
vim.pack.add({
    { src = "https://github.com/nvzone/showkeys", opt = true },
})

-- Show-keys
require("showkeys").setup({ position = "top-right" })
