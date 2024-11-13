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

function getVarType()
  local util = require('vim.lsp.util')
  local params = util.make_position_params()
  local ms = require('vim.lsp.protocol').Methods

  local method = ms.textDocument_hover

  local a = require 'plenary.async'
  local tx, rx = a.control.channel.oneshot()

  local run = function()
    a.run(function()
      -- handler function derived from /neovim/0.10.2_1/share/nvim/runtime/lua/vim/lsp/handlers.lua:M.hover()
      local handler = function(_, result, ctx, _)
        if vim.api.nvim_get_current_buf() ~= ctx.bufnr then
          -- Ignore result since buffer changed. This happens for slow language servers.
          return tx({ nil, "error cannot happen" })
        end
        if not (result and result.contents) then
          return tx({ nil, "Nothing sent from LSP" })
        end

        local contents ---@type string[]
        if type(result.contents) == 'table' and result.contents.kind == 'plaintext' then
          contents = vim.split(result.contents.value or '', '\n', { trimempty = true })
        else
          contents = util.convert_input_to_markdown_lines(result.contents)
        end
        if vim.tbl_isempty(contents) then
          return tx({ nil, 'No information available' })
        end

        local type = contents[2]:match("^var%s+%w+%s+(.*)$")
        if not type then
          vim.notify('Regex failed')
          return tx({ nil, "Regex failed" })
        end

        return tx({ type, nil })
      end

      vim.lsp.buf_request(0, method, params, handler)
      -- return unpack(rx())
      type, err = unpack(rx())
      print("first >>>>>>")
      print(type)
      print(err)
      return type, err
    end, _)
    -- print(vim.inspect(g))
    print("end run")
  end
  type, err = run()
  print("second")
  print(type)
  print(err)
end

-- append
local append = postfix("a", {
  f(function(_, parent)
    type, err = getVarType()
    -- print(vim.inspect(type))
    -- print(vim.inspect(err))
    if not type then
      -- vim.notify(err)
      return nil
    end
    if string.sub(type, 1, 2) ~= "[]" then
      -- vim.notify("Type not slice")
      return nil
    end

    local var = parent.snippet.env.POSTFIX_MATCH
    return var .. " = append(var, )"
  end, {}),
})
table.insert(snippets, append)


return snippets, autosnippets
