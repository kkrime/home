local ls = require("luasnip") --{{{
local s = ls.s                --> snippet
local i = ls.i                --> insert node
local t = ls.t                --> text node

local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local snippets, autosnippets = {}, {} --}}}

local group = vim.api.nvim_create_augroup("Lua Snippets", { clear = true })
local file_pattern = "*.go"

-- local print_var = s("ff", fmt([[
-- fmt.Printf("{} = %v\n", {})
-- ]], { i(1, "var"), rep(1) }))
--
--
local same = function(index)
  return f(function(arg)
    return arg[1]
  end, { index })
end

local print_var = s("ff", {
  t("fmt.Printf(\""),
  -- rep(1),
  same(1),
  t(" = %+v\\n\", "),
  i(1, "var"),
  t(")"),
})

table.insert(snippets, print_var)

return snippets, autosnippets
