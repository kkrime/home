local ls = require("luasnip")
local events = require("luasnip.util.events")

local k = require("luasnip.nodes.key_indexer").new_key

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

local print_var = s("p", {
  t("log.d(\""),
  rep(1),
  t(" = ${"),
  i(1, "var"),
  t("}\");"),
})
table.insert(snippets, print_var)

local stateless_class = s("sl", {
  -- class
  t("class "),
  i(1, "", { key = "class_name" }),
  t({ " extends StatefulWidget {" }),
  isn(2, {
      t({ "", "" }),
      t("const "),
      rep(k("class_name")),
      t("({super.key});"),
      t({ "", "" }),
      t({ "", "" }),
      t({ "@override", "_" }),
      rep(k("class_name")),
    },
    "$PARENT_INDENT\t"),
  t(" createState() => _"),
  rep(1), t("();"),
  t({ "", "}", "", "" }),
  -- state
  t("class _"), rep(1), t(" extends State<"), rep(1), t({ "> {" }),

  isn(3, {
      t({ "", "" }),
      t({ "@override", "" }),
      t({ "Widget build(BuildContext context) {" }),
      isn(1, {
          t({ "", "return " }),
          -- i(1, ""),
          i(1, "",
            {
              node_callbacks = {
                [events.enter] = function()
                  vim.notify("Wo0p!")
                end
              }
            }
          ),
          t(";"),
        },
        "$PARENT_INDENT\t"),
      t({ "", "}" }),
    },
    "$PARENT_INDENT\t"),
  -- i(2, ""),
  t({ "", "}", "" }),
})
table.insert(snippets, stateless_class)

local stateless_class = s("s", {
  -- class
  t("class "),
  i(1, "", { key = "class_name" }),
  t({ " extends StatelessWidget {" }),
  isn(2, {
      t({ "", "" }),
      t("const "),
      rep(k("class_name")),
      t("({super.key});"),
      t({ "", "" }),
      t({ "", "" }),
      t({ "@override", "" }),
      t({ "Widget build(BuildContext context) {" }),
      isn(1, {
          t({ "", "return " }),
          -- i(1, ""),
          i(1, "",
            {
              node_callbacks = {
                [events.enter] = function()
                  vim.notify("Wo0p!")
                end
              }
            }
          ),
          t(";"),
        },
        "$PARENT_INDENT\t"),
      t({ "", "}" }),
    },
    "$PARENT_INDENT\t"),
  -- i(2, ""),
  t({ "", "}", "" }),
})
table.insert(snippets, stateless_class)

local shrink = s("sh", {
  t("SizedBox.shrink()"),
})
table.insert(snippets, shrink)

local _if = s("i", {
  isn(1, {
      t("if ("),
      i(1, ""),
      t(") {"),
      isn(2, {
          t({ "", "" }),
          i(1, ""),
        },
        "$PARENT_INDENT\t"),
      t({ "", "}" }),
    },
    "$PARENT_INDENT"),
})
table.insert(snippets, _if)

local _if = s("if", {
  isn(1, {
      t("if ("),
      i(1, ""),
      t(")"),
      isn(2, {
          t({ "", "" }),
          i(1, ""),
        },
        "$PARENT_INDENT\t"),
    },
    "$PARENT_INDENT"),
})
table.insert(snippets, _if)

local _if = s("i", {
  isn(1, {
      t("if ("),
      i(1, ""),
      t(") {"),
      isn(2, {
          t({ "", "" }),
          i(1, ""),
        },
        "$PARENT_INDENT\t"),
      t({ "", "}" }),
    },
    "$PARENT_INDENT"),
})
table.insert(snippets, _if)

local closure = s("c", {
  isn(1, {
      t("() {"),
      isn(1, {
          t({ "", "" }),
          i(1, ""),
        },
        "$PARENT_INDENT\t"),
      t({ "", "" }),
      t("}"),
    },
    "$PARENT_INDENT"),
})

table.insert(snippets, closure)

local closure_inline = s("ci", {
  isn(1, {
      t("(() {"),
      isn(1, {
          t({ "", "" }),
          i(1, ""),
        },
        "$PARENT_INDENT\t"),
      t({ "", "" }),
      t("})()"),
    },
    "$PARENT_INDENT"),
})
table.insert(snippets, closure_inline)

local widget_function = s("w", {
  isn(1, {
      t("Widget "),
      i(1, ""),
      t("() {"),
      isn(2, {
          t({ "", "" }),
          t("return"),
          t({ "", "" }),
          i(1, ""),
          t({ "", "" }),
          t(";"),
        },
        "$PARENT_INDENT\t"),
      t({ "", "" }),
      t("}"),
      t({ "", "" }),
    },
    "$PARENT_INDENT"),
})
table.insert(snippets, widget_function)

return snippets, autosnippets
