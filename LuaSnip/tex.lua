-- Two common LuaSnip abbreviations
local status_ok, ls = pcall(require, "luasnip")
if not status_ok then return end

local s = ls.snippet
local i = ls.insert_node
local sn = ls.snippet_node
local t = ls.text_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
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

local align = s(
    {
        trig = "ali",
        dscr = "Wrap the selected text in an aligned block.",
    },
    {
        t("\\begin{aligned}"),
        d(1, get_visual),
        t("\\end{aligned}")
    })

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

local environment = s(
{
trig="begin",
dscr="Insert a new environment", 
regTrig = false, 
},
fmt([[
\begin{<>}
<>
\end{<>}
]],
{i(1), i(2), rep(1)},
{delimiters = "<>"}
)
)



return { align, title, environment }
