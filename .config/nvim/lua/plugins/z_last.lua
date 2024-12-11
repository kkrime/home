vim.keymap.set("n", "*", function()
  local inital_first_visible_line = vim.fn.line("w0")
  local inital_last_visible_line = vim.fn.line("w$")
  local inital_line, inital_col = unpack(vim.api.nvim_win_get_cursor(0))

  vim.cmd('normal! *')

  local win_height = vim.api.nvim_win_get_height(0) - 2
  local last_line = vim.api.nvim_buf_line_count(0)

  local last_page = last_line - win_height

  local new_line, new_col = unpack(vim.api.nvim_win_get_cursor(0))

  local new_first_visible_line = vim.fn.line("w0")
  local new_last_visible_line = vim.fn.line("w$")

  if new_line >= last_line then
    return
  end

  local padding = math.ceil(((win_height) / 8.0) - 1) * 2.5

  local space_from_bottom = new_last_visible_line - new_line
  -- vim.api.nvim_win_set_cursor(0, { inital_line, inital_col })
  if space_from_bottom < padding then
    local jump = padding - space_from_bottom

    vim.api.nvim_set_hl(0, 'MyHighlightGroup', {
      -- fg = '#000000', -- foreground color (red in this case)
      bg = '#ff0000', -- foreground color (red in this case)
      -- bg = '#000000', -- background color (black in this case)
      bold = true,    -- make text bold
      -- underline = true -- underline the text
    })

    vim.o.cursorline = false
    local ns_id = vim.api.nvim_create_namespace("highlight_current_line")

    -- Set an extmark to highlight the current line with the custom highlight
    local id = vim.api.nvim_buf_set_extmark(0, ns_id, inital_line - 1, 0, {
      end_row = inital_line,
      end_col = 0,
      -- hl_group = "CursorLine", -- Use the custom highlight group
      hl_group = "MyHighlightGroup", -- Use the custom highlight group
      priority = 1000,
      hl_eol = true
    })

    vim.api.nvim_win_set_cursor(0, { new_last_visible_line, 0 })
    for i = 1, jump / 2 do
      -- for i = 1, jump + space_from_bottom do
      vim.cmd('normal! 2j') -- Move the cursor down by one line
      -- vim.api.nvim_feedkeys("j", 'x', false)
      vim.cmd('redraw')
      vim.wait(15)
    end

    vim.o.cursorline = true
    vim.api.nvim_win_set_cursor(0, { new_line, new_col })
    vim.cmd('redraw')

    vim.defer_fn(function()
      vim.api.nvim_buf_del_extmark(0, ns_id, id)
    end, 500)

    vim.o.cursorline = true
    -- vim.api.nvim_buf_del_extmark(0, ns_id, id)
    return
  end

  -- vim.api.nvim_buf_del_extmark(0, ns_id, res)
  local new_position = new_line - padding

  -- vim.api.nvim_feedkeys(new_position .. "zt", 'x', true)

  -- vim.api.nvim_win_set_cursor(0, { new_line, col })
end, { silent = true, noremap = true })


return {}
