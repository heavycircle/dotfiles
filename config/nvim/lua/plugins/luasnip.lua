local M = {}

function M.install()
    vim.pack.add({
        { src = "https://github.com/L3MON4D3/LuaSnip" },
    })
end

function M.setup()
    M.install()

    require("luasnip").setup({ enable_autosnippets = true })
    local ls = require "luasnip"

    -- Expand the snippet
    vim.keymap.set("i", "<C-e>", function()
        ls.expand_or_jump(1)
    end, { silent = true })

    -- Jump to the next insertion point
    vim.keymap.set({ "i", "s" }, "<C-j>", function()
        if ls.expand_or_jumpable() then
            ls.jump(1)
        end
    end, { silent = true })

    -- Jump to the previous insertion point
    vim.keymap.set({ "i", "s" }, "<C-k>", function()
        if ls.expand_or_jumpable() then
            ls.jump(-1)
        end
    end, { silent = true })

    -- Use the previous choice in a list of choices
    vim.keymap.set({ "i", "s" }, "<C-h>", function()
        if ls.choice_active() then
            ls.change_choice(-1)
        end
    end, { silent = true })

    -- Use the next choice in a list of choices
    vim.keymap.set({ "i", "s" }, "<C-l>", function()
        if ls.choice_active() then
            ls.change_choice(1)
        end
    end, { silent = true })

    require "plugins.snippets.all"
    require "plugins.snippets.c"
    require "plugins.snippets.python"
    require "plugins.snippets.sh"
end

return M
