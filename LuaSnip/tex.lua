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
function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
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

local columns = s(
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

local wrapenv = s(
    {
        trig = "_bg",
        snippetType = "autosnippet",
        wordTrig = true,
        dscr = "Wrap the selected text in an envrionment block.",
        condition = in_select_mode
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
        trig = "_aa",
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
        trig = "_cm",
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


local title = s(
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
)

local italic = s(
    {
        trig = "_i",
        dscr = "Italics",
        regTrig = true,
    },
    fmt([[
\textit{<>}
]],
        { i(1) },
        { delimiters = "<>" }
    )
)

local boldface = s(
    {
        trig = "_b",
        dscr = "Boldface",
        regTrig = true,
    },
    fmt([[
\textbf{<>}
]],
        { i(1) },
        { delimiters = "<>" }
    )
)
local textcolor = s(
    {
        trig = "_tc",
        dscr = "textcolor",
        regTrig = true,
    },
    fmt([[
\textcolor{<>}{<>}
]],
        { i(1), i(2) },
        { delimiters = "<>" }
    )
)
local alert = s(
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



return {
    alert,
    textcolor,
    align,
    title,
    environment,
    italic,
    boldface,
    wrapenv,
    wrapcmd,
    columns,
    sidenote
}
