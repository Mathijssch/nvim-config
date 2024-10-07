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

local snippets = {}

-- Title
table.insert(snippets, s(
    {
        trig = "_title",
        dscr = "Draw a title line in comments",
        wordTrig = false,
    },
    fmt(
        [[
        #-------------------------------------------------------------
        # <>
        #-------------------------------------------------------------
    ]]
        , { i(1) },
        { delimiters = "<>" }
    )
)
)

table.insert(snippets, s(
    {
        trig = "if __name",
        dscr = "`if __name__ == '__main__'",
        regTrig = false
    },
    t([[if __name__ == "__main__" ]])
)
)

table.insert(snippets, s(
    {
        trig = "_pytest",
        dscr = "Set up a new pytest file",
        regTrig = false
    },
    fmt([[
    import pytest
    {}
    if __name__ == '__main__':
        pytest.main([__file__])]],
        { i(1) }
    )
)
)



return snippets
