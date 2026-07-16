vim.api.nvim_create_user_command('Z', function()
  vim.cmd("e ~/.config/nvim/lua/plugins/z_last.lua")
end, {})


vim.keymap.del("n", "<C-h>")

vim.keymap.set("n", "<C-h>", function()
  require("buildtargets").select_buildtarget()
end)

-------------------------------------------------------------------------------------------------------------------------------------
local snips = require('go.snips')

local ok, ts_locals = pcall(require, 'nvim-treesitter.locals')
if not ok then
  ts_locals = require('guihua.ts_obsolete.locals')
end

vim.keymap.del("n", "<C-h>")
vim.keymap.set("n", "<C-h>", function()
  -- local res = snips.make_return_nodes({ { "err" } })
  -- vim.notify(vim.inspect({ "res", res }))
  vim.treesitter.query.set(
    'go',
    'LuaSnip_Result',
    [[
      [
        (method_declaration result: (_) @id)
        (function_declaration result: (_) @id)
        (func_literal result: (_) @id)
      ]
  ]]
  )
  local cursor_node = vim.treesitter.get_node({ bufnr = 0 })
  local t = ts_locals.previous_scope(cursor_node)
  vim.notify(vim.inspect({ "var", var }))
  vim.notify(vim.inspect({ " cursor_node", cursor_node:type() }))
  local scope_tree = ts_locals.get_scope_tree(cursor_node, 0)
  -- local scope_tree = vim.treesitter .get_scope_tree(cursor_node, 0)
  for _, scope in ipairs(scope_tree) do
    vim.notify(vim.inspect({ "scope", scope:type() }))
  end
end)


return {}
