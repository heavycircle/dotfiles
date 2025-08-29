-- Use the treesitter master branch because it's easier to configure

local M = {}

function M.install()
    vim.pack.add({
        { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "master", build = ":TSUpdate" },
    })
end

function M.setup()
    M.install()

    require 'nvim-treesitter.configs'.setup {
        -- A list of parser names, or "all" (the listed parsers MUST always be installed)
        ensure_installed = {
            "bash",
            "c", "cmake",
            "dockerfile",
            "lua",
            "python",
            "typescript", "prisma", "javascript", "html", "css", "json",
            "asm", "nasm"
        },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,
        auto_install = true,
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
    }

    -- Treesitter Highlights
    vim.api.nvim_create_autocmd("FileType", {
        pattern = { '<filetype>' },
        callback = function() vim.treesitter.start() end,
    })

    -- Treesitter indentation
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
end

return M
