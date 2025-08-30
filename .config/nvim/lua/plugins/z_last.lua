vim.api.nvim_create_user_command('Z', function()
  vim.cmd("e ~/.config/nvim/lua/plugins/z_last.lua")
end, {})

vim.keymap.set("n", "<C-h>", function()
  require("buildtargets").select_buildtarget()
end)

return {}

