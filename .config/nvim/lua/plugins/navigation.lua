local divide_height_by = 5

vim.keymap.set("n", "<C-d>", function()
  local win_height = vim.api.nvim_win_get_height(0)
  local count = math.floor(win_height / divide_height_by)
  vim.cmd("normal! " .. count .. "j")
end, { silent = true, noremap = true })

vim.keymap.set("n", "<C-u>", function()
  local win_height = vim.api.nvim_win_get_height(0)
  local count = math.floor(win_height / divide_height_by)
  vim.cmd("normal! " .. count .. "k")
end, { silent = true, noremap = true })

return {}
