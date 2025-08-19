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

ls.add_snippets("python", {
    -- Python logging function
    s(
        { trig = "log", name = "logger", dscr = "logger" },
        f(
            [[
            logger.<>(f"<>")
            ]],
            {
                c(1, {
                    t("debug"),
                    t("info"),
                    t("warning"),
                    t("error"),
                    t("critical")
                }),
                i(2)
            },
            { delimiters = "<>" }
        )
    ),

    -- Commented functions
    s(
        { trig = "def", name = "function", dscr = "function" },
        f(
            [[
             def <>(<>: <>) ->> <>:
             """
             <>

             :param <>: <>
             :return: <>
             """
             {
             }
            ]],
            { i(1, "function"), i(2, "param"), i(3, "type"), i(4, "ret"),
                i(5, "comment"), r(2), i(6, "purpose"), i(7, "returns") },
            { delimiters = "<>" }
        )
    )
})
