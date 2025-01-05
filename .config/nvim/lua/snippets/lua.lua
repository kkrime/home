local ls = require("luasnip") --{{{
local s = ls.s                --> snippet
local i = ls.i                --> insert node
local t = ls.t                --> text node
local l = extras.lambda
local postfix = require("luasnip.extras.postfix").postfix

local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node

-- local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local snippets, autosnippets = {}, {} --}}}

local group = vim.api.nvim_create_augroup("Lua Snippets", { clear = true })

local print_var = s("ni", {
  t("vim.notify(vim.inspect({ \""),
  rep(1),
  t("\", "),
  i(1, "var"),
  t(" }"),
  t("))"),
})
table.insert(snippets, print_var)
vim.notify(vim.inspect({ "here", here }))

local inspect_var = s("n", {
  t("vim.notify(\""),
  i(1, ""),
  t("\""),
  t(")"),
})

table.insert(snippets, inspect_var)

print_var = s("pv", {
  t("print(\""),
  rep(1),
  t("\", "),
  i(1, "var"),
  t(")"),
})
table.insert(snippets, print_var)

print_var = s("p", {
  t("print(\""),
  -- rep(1),
  -- t(" \" .. "),
  i(1),
  t("\")"),
})
table.insert(snippets, print_var)

return snippets, autosnippets
