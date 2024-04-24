-- Two common LuaSnip abbreviations
local status_ok, ls = pcall(require, "luasnip")
if not status_ok then return end
local s = ls.snippet
local i = ls.insert_node
local sn = ls.snippet_node
local t = ls.text_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

-- from https://www.ejmastnak.com/tutorials/vim-latex/luasnip/#getting-started
-- ----------------------------------------------------------------------------
-- Summary: When `SELECT_RAW` is populated with a visual selection, the function
-- returns an insert node whose initial text is set to the visual selection.
-- When `SELECT_RAW` is empty, the function simply returns an empty insert node.
local get_visual = function(args, parent)
    if (#parent.snippet.env.SELECT_RAW > 0) then
        return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
    else -- If SELECT_RAW is empty, return a blank insert node
        return sn(nil, i(1))
    end
end
-- ----------------------------------------------------------------------------
-- Title
--
local snippets = {}

table.insert(snippets, s(
    {
        trig = "_<",
        snippetType = "autosnippet",
        wordTrig = true,
        dscr = "Wrap the selected text in an envrionment block.",
        --condition = in_select_mode
    },
    fmta([[
        <{}>
            {}
        </{}>
        ]],
        { i(1), d(2, get_visual), rep(1) },
        { delimiters = "{}" }
    )
))

table.insert(snippets, s(
    {
    trig = "_subtitle",
        snippetType = "autosnippet",
        dscr = "Add a subtitle.",
    },
    fmt([[
    <span class="subtitle">
    {}
    </span>
    ]],
        { d(1, get_visual) },
        { delimiters = '{}' })
))

table.insert(snippets, s(
    {
        trig = "_clr",
        snippetType = "autosnippet",
        wordTrig = true,
        dscr = "Wrap in a span with a color",
    },
    fmta([[<span style="color: {};">{}</span>]],
        { i(1), d(2, get_visual) },
        { delimiters = "{}" }
    )
))

table.insert(snippets, s({
        trig = "_frag",
        snippetType = "autosnippet",
        dscr = "Add a fragment.",
    },
    fmt([[
<div class="fragment">
{}
</div>
    ]],
        { d(1, get_visual) },
        { delimiters = '{}' })
))


table.insert(snippets, s(
    {
        trig = "_rmrk",
        snippetType = "autosnippet",
        dscr = "Add a remark span.",
    },
    fmt([[<span class="sidenote">{}</span>]],
        { i(1) },
        { delimiters = '{}' })
))

table.insert(snippets, s(
    {
        trig = [[begin]],
        --snippetType = "autosnippet",
        wordTrig = true,
        dscr = "Wrap the selected text in an envrionment block.",
        --condition = in_select_mode
    },
    fmta([[
        \begin{<>}<>
            <>
        \end{<>}
        ]],
        { i(1), i(2), d(3, get_visual), rep(1) }
    )
))

table.insert(snippets, s(
    {
        trig = "_a",
        snippetType = "autosnippet",
        wordTrig = true,
        dscr = "Wrap the selected text in an aligned block.",
    },
    fmta([[
\begin{aligned}
<>
\end{aligned}
        ]],
        { d(1, get_visual) }
    )
))

table.insert(snippets, s(
    {
        trig = "_c",
        snippetType = "autosnippet",
        wordTrig = true,
        dscr = "Wrap current selection in a command",
    },
    fmta([[\<>{<><>}]],
        { i(1), d(2, get_visual), i(3) }
    )
))

table.insert(snippets, s(
    {
        trig = "_sn",
        snippetType = "autosnippet",
        wordTrig = true,
        dscr = "Wrap current selection in a sidenote",
    },
    fmta([[\sidenote[<>]{<>}]],
        { d(1, get_visual), i(2) }
    )
))


table.insert(snippets, s(
    {
        trig = "_div",
        snippetType = "autosnippet",
        dscr = "Add a new div.",
    },
    fmt([[
<div class="{}">
    {}
</div>
]],
        { i(1), i(2) },
        { delimiters = '{}' })
))

return snippets
