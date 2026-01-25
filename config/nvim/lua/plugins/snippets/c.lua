local ls = require("luasnip")
local ex = require("luasnip.extras")
local fm = require("luasnip.extras.fmt")

local s = ls.snippet
local i = ls.insert_node

local r = ex.rep
local f = fm.fmt

ls.add_snippets("c", {
	s(
		{ trig = "fn", name = "function", dscr = "function" },
		f(
			[[
            /**
             * <>
             *
             * @param <> <>
             * @return <>
             */
             <> <>(<> <>)
             {
             }
            ]],
			{
				i(1, "comment"),
				i(2, "param"),
				i(3, "purpose"),
				i(4, "ret"),
				i(5, "void"),
				i(6, "function"),
				i(7, "int"),
				r(2),
			},
			{ delimiters = "<>" }
		)
	),
})
