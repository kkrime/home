local function function_jump(direction)
  local node = vim.treesitter.get_node()

  local source_file = 95
  local function_declaration = 107
  local method_declaration = 108
  local parent
  while (true) do
    if node == nil or node:symbol() == source_file then
      break
    end

    parent = node:parent()
    local function_node

    if node:symbol() == function_declaration or node:symbol() == method_declaration then
      function_node = node
    elseif parent:symbol() == function_declaration or parent:symbol() == method_declaration then
      function_node = parent
    end
    if function_node ~= nil then
      local start_row, start_col, end_row, end_col = function_node:range()
      local row, col
      if direction == 'k' then
        row = start_row + 1
        col = start_col
      elseif direction == 'j' then
        row = end_row + 1
        col = end_col - 1
        vim.notify(vim.inspect({ "end_col", end_col }))
      end
      if col == 0 then
        vim.cmd("normal! m'")
        vim.api.nvim_win_set_cursor(0, { row, 0 })
        break
      end
    end
    node = parent
  end
end

vim.keymap.set({ "n", "v" }, "<C-k>", function()
  function_jump('k')
end, { silent = true, noremap = true })

vim.keymap.set({ "n", "v" }, "<C-j>", function()
  function_jump('j')
end, { silent = true, noremap = true })

local divide_height_by = 5
vim.keymap.set({ "n", "v" }, "<C-d>", function()
  local win_height = vim.api.nvim_win_get_height(0)
  local count = math.floor(win_height / divide_height_by)
  vim.cmd("normal! " .. count .. "j")
end, { silent = true, noremap = true })

vim.keymap.set({ "n", "v" }, "<C-u>", function()
  local win_height = vim.api.nvim_win_get_height(0)
  local count = math.floor(win_height / divide_height_by)
  vim.cmd("normal! " .. count .. "k")
end, { silent = true, noremap = true })

return {}
