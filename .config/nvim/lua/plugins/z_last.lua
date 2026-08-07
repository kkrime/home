vim.api.nvim_create_user_command('Z', function()
  vim.cmd("e ~/.config/nvim/lua/plugins/z_last.lua")
end, {})


-- vim.keymap.del("n", "<C-h>")

vim.keymap.set("n", "<C-m>", function()
  -- require("buildtargets").select_buildtarget()
end)

-------------------------------------------------------------------------------------------------------------------------------------
-- local snips = require('go.snips')

local ok, ts_locals = pcall(require, 'nvim-treesitter.locals')
if not ok then
  ts_locals = require('guihua.ts_obsolete.locals')
end

vim.keymap.del("n", "<C-m>")
vim.keymap.set("n", "<C-m>", function()
end)


return {}
