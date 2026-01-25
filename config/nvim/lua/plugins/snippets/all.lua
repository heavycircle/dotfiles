local ls = require("luasnip")
local ex = require("luasnip.extras")
local fm = require("luasnip.extras.fmt")

local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node

local c = ls.choice_node
local r = ex.rep
local f = fm.fmt

ls.add_snippets("all", {
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

	s("date", t(os.date("%B %d, %Y"))),
})
