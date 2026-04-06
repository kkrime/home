local snippets, autosnippets = {}, {} --}}}

local log_info = s("l", {
  t("log.d(\""),
  i(1, ""),
  t("\");"),
})
table.insert(snippets, log_info)

local print_var = s("p", {
  t("log.d(\""),
  rep(1),
  t(" = ${"),
  i(1, "var"),
  t("}\");"),
})
table.insert(snippets, print_var)

return snippets, autosnippets
