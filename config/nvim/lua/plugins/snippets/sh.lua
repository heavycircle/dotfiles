local ls = require "luasnip"
local ex = require "luasnip.extras"
local fm = require "luasnip.extras.fmt"

local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node

local r = ex.rep
local f = fm.fmt

ls.add_snippets("sh", {
    -- Case block snippets.
    s(
        { trig = "case", name = "cases", dscr = "cases" },
        f(
            [[
            case <1> in
                <2>) <3> ;;
                *) <4> ;;
            esac
            ]],
            { i(1, "expr"), i(2, "pattern"), i(3, "command"), i(4, "exit 1") },
            { delimiters = "<>" }
        )
    ),

    -- Argparse snippets.
    -- Note that the delimiter conflicts with the > in the conditional.
    -- LuaSnip demands we double it up to deconflict.
    s(
        { trig = "args", name = "argparse", dscr = "argparse" },
        f(
            [[
            # Drain flags
            local -a positional
            while (($# >> 0)); do
                case "$1" in
                    <1>) <2> ;;
                    -h | --help) usage ;;
                    --) shift; break ;;
                    --*) fatal "unknown option: --$1" ;;
                    -*) fatal "unknown option: -$1" ;;
                    *) positional+=("$1") ;;
                esac
                shift
            done
            set -- "${positional[@]}"
            ]],
            { i(1, "flag"), i(2, "command") },
            { delimiters = "<>" }
        )
    ),
})
