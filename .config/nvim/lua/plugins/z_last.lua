vim.keymap.set("n", "*", function()
  vim.cmd('normal! *')
  -- local line = math.floor(((vim.o.lines) / 5.0) - 1)
  -- vim.notify(vim.inspect({ line = line }))

  local win_height = vim.api.nvim_win_get_height(0) - 2
  -- vim.notify(vim.inspect({ win_height = win_height }))
  local last_line = vim.api.nvim_buf_line_count(0)
  -- vim.notify(vim.inspect({ last_line = last_line }))

  local last_page = last_line - win_height
  vim.notify(vim.inspect({ last_page = last_page }))

  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  -- vim.notify(vim.inspect({ row = row }))

  if row >= last_page then
    return
  end
  local position = math.floor(((vim.o.lines) / 13.0) - 1)

  local new_position = row - position

  vim.api.nvim_feedkeys(new_position .. "zt", 'x', true)

  vim.api.nvim_win_set_cursor(0, { row, col })
end, { silent = true, noremap = true })







return {}

