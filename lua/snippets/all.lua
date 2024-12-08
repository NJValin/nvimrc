local ls = require("luasnip")

-- This is a snippet creator
-- s(<trigger>, <nodes>)
local s = ls.s
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node

-- This is an insert node
-- It takes a position (like $1) and optionally some default text
-- i(<position>, [default_text])
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda

-- Repeats a node
-- rep(<position>)
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
--
-- This is a format node.
-- It takes a format string, and a list of nodes
-- fmt(<fmt_string>, {..nodes>})
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_key

return {
    s(
        "date",
        f(function()
            return os.date("%y-%m-%d")
        end)
    ),


}
