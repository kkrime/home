vim.api.nvim_create_user_command('Z', function()
  vim.cmd("e ~/.config/nvim/lua/plugins/z_last.lua")
end, {})


vim.keymap.del("n", "<C-h>")

vim.keymap.set("n", "<C-h>", function()
  require("buildtargets").select_buildtarget()
end)

-------------------------------------------------------------------------------------------------------------------------------------
vim.keymap.del("n", "<C-h>")
vim.keymap.set("n", "<C-h>", function()
local maps = vim.api.nvim_get_keymap('n') -- 'n' for normal mode
for _, map in pairs(maps) do
    print(map.script) -- Prints the script/file where it was defined
end
end)

return {}
