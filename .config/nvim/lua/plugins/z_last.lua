vim.api.nvim_create_user_command('Z', function()
  vim.cmd("e ~/.config/nvim/lua/plugins/z_last.lua")
end, {})



vim.keymap.set("n", "<C-h>", function()
  require("buildtargets").select_buildtarget()
end)

-- local ControlPlusDown = "<ESC>[1;5B"
-- local ControlPlusDown = ''
-- local ControlPlusDown = "[1;5B"
-- local ControlPlusDown = "<C-DOWN>"
-- local ControlPlusDown = "<C-UP>"
-- local ControlPlusDown = "<C-RIGHT>"
local ControlPlusDown = "<C-LEFT>"
-- local ControlPlusDown = "<C-h>"
vim.keymap.set("n", ControlPlusDown, function()
  vim.notify("INSIDE")
end, { noremap = true })

return {}
