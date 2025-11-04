local function function_jump(direction)
  local node = vim.treesitter.get_node()
  if node == nil then
    return
  end

  local up, down = false, false
  if direction == 'k' then
    up = true
  elseif direction == 'j' then
    down = true
  end

  local source_file = 95
  local function_declaration = 107
  local method_declaration = 108

  local current_line = vim.api.nvim_win_get_cursor(0)[1]

  local function_node
  while (function_node == nil) do
    if node:symbol() == source_file then
      local new_node
      local next
      if up then
        local prev = node
        for child, _ in node:iter_children() do
          next = child
          local _, _, end_row, _ = next:range()
          end_row = end_row + 1
          if end_row > current_line then
            new_node = prev
            break
          end
          if next:symbol() == function_declaration or next:symbol() == method_declaration then
            prev = next
          end
        end
      elseif down then
        for child, _ in node:iter_children() do
          next = child
          local start_row, _, _, _ = next:range()
          start_row = start_row + 1
          if start_row > current_line then
            if next:symbol() == function_declaration or next:symbol() == method_declaration then
              new_node = next
              break
            end
          end
        end
      end

      if new_node == nil then
        return
      end

      -- node = new_node
      -- function_node = node
      function_node = new_node
      down = not down
      up = not up
    else
      local parent = node:parent()

      if node:symbol() == function_declaration or node:symbol() == method_declaration then
        function_node = node
      elseif parent ~= nil then
        if parent:symbol() == function_declaration or parent:symbol() == method_declaration then
          function_node = parent
        end
      end

      if function_node == nil then
        node = parent
        if node == nil then
          return
        end
      end
    end
  end
  node = function_node

  local start_row, start_col, end_row, end_col = node:range()
  start_row = start_row + 1
  end_row = end_row + 1

  local start, end_ = false, false
  if start_row == current_line then
    start = true
  elseif end_row == current_line then
    end_ = true
  end

  local row, col
  if start == false and end_ == false then
    if up then
      row = start_row
      col = start_col
    elseif down then
      row = end_row
      col = end_col - 1
    end
  else
    if up and start then
      while (node ~= nil) do
        node = node:prev_sibling()
        if node == nil then
          return
        end
        if node:symbol() == function_declaration or node:symbol() == method_declaration then
          break
        end
      end
      if node == nil then
        return
      end
      _, _, row, col = node:range()
      row = row + 1
      col = col - 1
    elseif up then
      row = start_row
      col = start_col
    elseif down and end_ then
      while (node ~= nil) do
        node = node:next_sibling()
        if node == nil then
          return
        end
        if node:symbol() == function_declaration or node:symbol() == method_declaration then
          break
        end
      end
      if node == nil then
        return
      end
      row, col, _, _ = node:range()
      row = row + 1
      col = col
    elseif down then
      row = end_row
      col = end_col - 1
    end
  end

  if col == 0 then
    vim.notify(vim.inspect({ "jump", jump }))
    vim.cmd("normal! m`")
    vim.api.nvim_win_set_cursor(0, { row, col })
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
