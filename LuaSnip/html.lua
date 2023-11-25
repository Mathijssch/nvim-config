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
local boilerplate = s(
    {
        trig = "_html",
        dscr = "standard html boilerplate.",
        regTrig = false
    },
    fmt(
        [[
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>{}</title>
    <link rel="stylesheet" href="style.css">
  </head>
  <body>
	<script src="index.js"></script>
  </body>
</html>
    ]]
        , { i(1) },
        { delimiters = "{}" }
    )
)

local columns = s(
    {
        trig = "_coll",
        snippetType = "autosnippet",
        wordTrig = false,
        dscr = "Add a columns environment"
    },
    fmta([[
    <div class="columns">
        <div class="col-reg">
            {}
        </div>
        <div class="col-reg">
            {}
        </div>
    </div>
    ]],
        { i(1), i(2) },
        { delimiters = "{}" }
    )
)

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

local environment = s(
    {
        trig = "begin",
        dscr = "Insert a new environment",
        regTrig = false,
    },
    fmt([[
\begin{<>}<>
    <>
\end{<>}
]],
        { i(1), i(2), i(3), rep(1) },
        { delimiters = "<>" }
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

local todo = s(
    {
        trig = "_todo",
        dscr = "Add a todo div",
    },
    fmt([[
<div class="todo">
{}
</div>
    ]],
        { i(1) },
        { delimiters = '{}' })
)

local fragment = s(
    {
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

local emph = s(
    {
        trig = "_emph",
        snippetType = "autosnippet",
        dscr = "Add an emphasized span.",
    },
    fmt([[<span class="emph">{}</span>]],
        { i(1) },
        { delimiters = '{}' })
)

local remrk = s(
    {
        trig = "_rmrk",
        snippetType = "autosnippet",
        dscr = "Add a remark span.",
    },
    fmt([[<span class="rmrk">{}</span>]],
        { i(1) },
        { delimiters = '{}' })
)

local ul = s(
    {
        trig = "_ul",
        snippetType = "autosnippet",
        dscr = "Add an unordered list.",
    },
    fmt([[
<ul>
    <li>{}
</ul>
]],
        { i(1) },
        { delimiters = '{}' })
)

local img = s(
    {
        trig = "_img",
        snippetType = "autosnippet",
        dscr = "Add an image.",
    },
    fmt([[<img src="{}"></img>]],
        { i(1) },
        { delimiters = '{}' })
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



return { boilerplate, columns, wrapenv, color, environment, todo, fragment, emph, remrk, ul, img, div}
