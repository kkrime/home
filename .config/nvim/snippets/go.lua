local ls = require("luasnip") --{{{
local s = ls.s                --> snippet
local i = ls.i                --> insert node
local t = ls.t                --> text node

local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node

-- local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local snippets, autosnippets = {}, {} --}}}

local group = vim.api.nvim_create_augroup("Lua Snippets", { clear = true })
local file_pattern = "*.go"

-- fmmt
local print_var = s("ff", {
  t("fmt.Printf(\""),
  rep(1),
  t(" = %+v\\n\", "),
  i(1, "var"),
  t(")"),
})
table.insert(snippets, print_var)

local print_ln = s("fl", {
  t("fmt.Println(\""),
  i(1, ""),
  t("\")"),
})
table.insert(snippets, print_ln)
-- log
local log_info_var = s("lif", {
  t("log.Infof(\""),
  rep(1),
  t(" = %+v\\n\", "),
  i(1, "var"),
  t(")"),
})
table.insert(snippets, log_info_var)

local log_info = s("li", {
  t("log.Info(\""),
  i(1, ""),
  t("\")"),
})
table.insert(snippets, log_info)

-- error
local return_error = s("er", {
  t({ "if err != nil {", "\treturn err", "}" }),
})
table.insert(snippets, return_error)

local return_error_ = s("er,", {
  t({ "if err != nil {", "\treturn " }),
  i(1, ""),
  t({ ", err", "}" }),
})
table.insert(snippets, return_error_)

local format_error = s("fe", {
  t("fmt.Errorf(\""),
  i(1, ""),
  t("\")"),
})
table.insert(snippets, format_error)

return snippets, autosnippets

