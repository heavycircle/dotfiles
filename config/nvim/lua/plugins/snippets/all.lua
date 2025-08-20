local ls = require "luasnip"
local ex = require "luasnip.extras"
local fm = require "luasnip.extras.fmt"

-- Basics
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node

-- Extras
local c = ls.choice_node
local r = ex.rep
local f = fm.fmt

ls.add_snippets("all", {
    -- Print information about me
    s(
        { trig = "me", name = "Attribution", dscr = "Attribution" },
        f(
            [[
            Author: heavycircle
            Date: <>
            License: MIT
            ]],
            { t(os.date("%B %Y")) },
            { delimiters = "<>" }
        )
    ),

    s("date", t(os.date("%B %d, %Y")))
})
