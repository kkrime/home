-- vim.keymap.set("n", "<C-h>", function()
--   require("buildtargets").select_buildtarget()
-- end)

-- local target = nil

vim.keymap.set("n", "<C-h>", function()
  local current_line_nr = vim.api.nvim_win_get_cursor(0)[1]
  local line = vim.fn.expand("%:p") .. ":" .. current_line_nr
  vim.notify(vim.inspect({ "line", line }))
  vim.notify(vim.inspect({ "vim.b.minihipatterns_config", vim.b.minihipatterns_config }))
end)

return {}

