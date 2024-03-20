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

local snippets = {}

local ruler = t("%-------------------------------------")


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


local function dump(o)
    if type(o) == 'table' then
        local str = '{ '
        for k, v in pairs(o) do
            if type(k) ~= 'number' then k = '"' .. k .. '"' end
            str = str .. '[' .. k .. '] = ' .. dump(v) .. ','
        end
        return str .. '} '
    else
        return tostring(o)
    end
end

-- Check if the cursor is currently in a beamer frame
local function is_in_frame(line_to_cursor, matched_trigger, captures)
    -- Index 1 returns the position of the match.
    local insideframe = vim.fn['vimtex#env#is_inside']('frame')[2]
    return insideframe == 1
end

local function in_select_mode(line_to_cursor, matched_trigger, captures)
    -- Index 1 returns the position of the match.
    --return #matched_trigger.snippet.env.SELECT_RAW > 0
    return #require("luasnip.util").get_raw(1) > 0
    --return mode == 'v' or mode == 'V' or mode == ''
end

table.insert(snippets, s(
    {
        trig = "_col",
        wordTrig = false,
        dscr = "Add a columns environment",
        condition = is_in_frame
    },
    fmta([[
    \begin{columns}
        \begin{column}{<>\textwidth}
        <>
        \end{column}
        \begin{column}{<>\textwidth}
        <>
        \end{column}
    \end{columns}
    ]],
        { i(1), i(3), i(2), i(4) }
    )
    )
)


table.insert(snippets, s(
    {
        trig = "_standalone",
        dscr = "scaffolding for a standalone document",
    },
    fmt([[
    \documentclass[tikz,dvipsnames]{standalone}
    \usepackage{pgfplots}

    \begin{document}
    \begin{tikzpicture}
    \tikzset{pt/.style={circle, inner sep=5pt, fill}}
    <>
    \end{tikzpicture}
    \end{document}
    ]],
        { i(1) },
        { delimiters = "<>" }
    )
))

table.insert(snippets, s(
    {
        trig = "_article",
        dscr = "scaffolding for an article",
    },
    fmt([[
    \documentclass{article}
    \title{}
    \author{}
    \date{}

    \begin{document}
    <>
    \end{document}
    ]],
        { i(1) },
        { delimiters = "<>" }
    )
))

table.insert(snippets, s(
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
))

table.insert(snippets, s(
    {
        trig = "_a",
        --snippetType = "autosnippet",
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
        trig = "_title",
        dscr = "Draw a title line in comments",
        regTrig = false
    },
    fmt(
        [[
        %-------------------------------------------------------------
        % <>
        %-------------------------------------------------------------
    ]]
        , { i(1) },
        { delimiters = "<>" }
    )
))

table.insert(snippets, s(
    {
        trig = "_it",
        snippetType = "autosnippet",
        dscr = "Italics",
        regTrig = true,
    },
    fmt([[
\textit{<>}
]],
        { d(1, get_visual) },
        { delimiters = "<>" }
    )
))

table.insert(snippets, s(
    {
        trig = "_b",
        snippetType = "autosnippet",
        dscr = "Boldface",
        regTrig = true,
    },
    fmt([[
\textbf{<>}
]],
        { d(1, get_visual) },
        { delimiters = "<>" }
    )
))
table.insert(snippets, s(
    {
        trig = "_tc",
        snippetType = "autosnippet",
        dscr = "textcolor",
        regTrig = true,
    },
    fmt([[
\textcolor{<>}{<>}
]],
        { i(1), i(2) },
        { delimiters = "<>" }
    )
))
table.insert(snippets, s(
    {
        trig = "_al",
        dscr = "alert",
        regTrig = true,
    },
    fmt([[
\alert{<>}
]],
        { i(1) },
        { delimiters = "<>" }
    )
))

table.insert(snippets, s(
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
))

table.insert(snippets, s(
    {
        trig = "_axis",
        dscr = "Insert a new axis",
    },
    fmt([[
    \begin{axis}[
        width=\textwidth,
        height=\textwidth,
        axis lines=center,
        xlabel={$x$},
        ylabel={$y$},
        enlarge x limits=0.01,
        enlarge y limits=0.01,
    ]
    <>
    \end{axis}
    ]],
        { i(1) },
        { delimiters = "<>" }
    )
))

table.insert(snippets, s(
    {
        trig = "_plot",
        dscr = "Add a plot",
    },
    fmt([[
    \addplot[domain=-1:1] {<>};
    ]],
        { i(1) },
        { delimiters = "<>" }
    )
)
)

return snippets
