local snippets, autosnippets = {}, {} --}}}

function snake_to_initials(args, parent, user_args)
  local name = args[1][1]
  vim.notify(vim.inspect({ "name", name }))

  local result = ""

  for word in string.gmatch(name, "[^_]+") do
    result = result .. string.sub(word, 1, 1)
  end

  return result
end

local log_info = s("l", {
  t("console.log(\""),
  i(1, ""),
  t("\");"),
})
table.insert(snippets, log_info)

local select = s("s", {
  t("SELECT * FROM "),
  i(1, "table_name"),
  t(" "),
  f(snake_to_initials, { 1 }),
  -- t(";"),
})
table.insert(snippets, select)

local join = s("j", {
  t("JOIN "),
  i(1, "table_name"),
  t(" "),
  f(snake_to_initials, { 1 }),
  t(" ON "),
  rep(1),
  t("."),
  i(2, "column_name"),
  t(" = "),
  i(3, "table_name"),
  t("."),
  i(4, "column_name"),
})
table.insert(snippets, join)

return snippets, autosnippets
