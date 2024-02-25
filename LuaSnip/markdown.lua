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

local wrapenv = s(
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
)

local color = s(
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
)

local fragment = s({
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
)


local remrk = s(
    {
        trig = "_rmrk",
        snippetType = "autosnippet",
        dscr = "Add a remark span.",
    },
    fmt([[<span class="sidenote">{}</span>]],
        { i(1) },
        { delimiters = '{}' })
)

local wrapenv = s(
    {
        trig = "be",
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
)

local align = s(
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
)

local wrapcmd = s(
    {
        trig = "_c",
        snippetType = "autosnippet",
        wordTrig = true,
        dscr = "Wrap current selection in a command",
    },
    fmta([[\<>{<><>}]],
        { i(1), d(2, get_visual), i(3) }
    )
)

local sidenote = s(
    {
        trig = "_sn",
        snippetType = "autosnippet",
        wordTrig = true,
        dscr = "Wrap current selection in a sidenote",
    },
    fmta([[\sidenote[<>]{<>}]],
        { d(1, get_visual), i(2) }
    )
)


local div = s(
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
)

return { wrapenv, color, wrapcmd, sidenote, align, fragment, remrk, div }
