local snippets, autosnippets = {}, {} --}}}

local log_info = s("l", {
  t("console.log(\""),
  i(1, ""),
  t("\");"),
})
table.insert(snippets, log_info)

local print_var = s("p", {
  t("console.log(`"),
  rep(1),
  t(" = ${"),
  t("JSON.stringify("),
  i(1, "var"),
  t(", null, 2)"),
  t("}`);"),
})
table.insert(snippets, print_var)

return snippets, autosnippets
