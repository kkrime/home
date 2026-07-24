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
  -- local session_name = require("auto-session.lib").current_session_name()
  -- vim.notify(vim.inspect({ "session_name", session_name }))
  -- local res = snips.make_return_nodes({ { "err" } })
  -- vim.notify(vim.inspect({ "res", res }))
end)


return {}
