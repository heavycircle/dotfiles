local ls = require "luasnip"

local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node

return {
    s("hello", {
        i(0),
        t('print("hello '),
        i(1),
        t('world")'),
        i(2),
    }),

    s("if", {
        t('if '),
        i(1, "true"),
        t(' then '),
        i(2),
        t(' end')
    })
}
