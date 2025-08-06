-- Autocommands

-- .nasm is an ASM file
vim.cmd([[ autocmd BufRead,BufNewFile *.nasm set filetype=asm ]])

-- Remove the background
vim.cmd(":hi statusline guibg=NONE")

-- Add :W command
vim.api.nvim_create_user_command("W", "w", {})
