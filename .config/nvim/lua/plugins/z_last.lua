function getVarType(line)
  local parser = vim.treesitter.get_parser(0, "go")
  local tree = parser:parse()[1]

  local ts_utils = require('nvim-treesitter.ts_utils')
  local ts_locals = require('nvim-treesitter.locals')

  local query = vim.treesitter.query.parse(
    "go", -- Language
    [[
      (method_declaration result: (_) @id)
      (function_declaration result: (_) @id)
      (func_literal result: (_) @id)
    ]])
  local cursor_node = ts_utils.get_node_at_cursor()
  local scope_tree = ts_locals.get_definition_scopes(cursor_node, 0)

  local function_node
  for i, scope in ipairs(scope_tree) do
    -- if scope:type() == 'function_declaration'
    --     or scope:type() == 'method_declaration'
    --     or scope:type() == 'method_declaration'
    --     or scope:type() == 'func_literal'
    -- then
    function_node = scope
    vim.notify(vim.inspect({ function_node = i .. " " .. function_node:type() }))
    break
    -- end
  end
end

local ns_id = vim.api.nvim_create_namespace("highlight_current_line")
vim.api.nvim_set_hl(0, 'MyHighlightGroup', {
  -- fg = '#000000', -- foreground color (red in this case)
  bg = '#ff0000', -- foreground color (red in this case)
  -- bg = '#000000', -- background color (black in this case)
  bold = true,    -- make text bold
  -- underline = true -- underline the text
})
local exmark_id
navigate = function(command, forward)
  if exmark_id ~= nil then
    vim.api.nvim_buf_del_extmark(0, ns_id, exmark_id)
  end
  local inital_line, inital_col = unpack(vim.api.nvim_win_get_cursor(0))

  local win_height = vim.api.nvim_win_get_height(0) - 2
  local last_line = vim.api.nvim_buf_line_count(0)

  local last_page = last_line - win_height

  command()

  local new_line, new_col = unpack(vim.api.nvim_win_get_cursor(0))

  local new_first_visible_line = vim.fn.line("w0")
  local new_last_visible_line = vim.fn.line("w$")

  if new_line >= last_line then
    return
  end

  local padding = math.ceil(((win_height) / 8.0) - 1) * 2.5

  local space_from_bottom = new_last_visible_line - new_line
  if space_from_bottom < padding then
    local jump = padding - space_from_bottom

    vim.o.cursorline = false

    -- highlight current line
    exmark_id = vim.api.nvim_buf_set_extmark(0, ns_id, inital_line - 1, 0, {
      end_row = inital_line,
      end_col = 0,
      hl_group = "MyHighlightGroup", -- Use the custom highlight group
      priority = 1000,
      hl_eol = true
    })

    -- getVarType(new_line)
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

    local new_id = exmark_id
    vim.defer_fn(function()
      if new_id == exmark_id then
        vim.api.nvim_buf_del_extmark(0, ns_id, exmark_id)
      end
    end, 500)

    vim.o.cursorline = true
    return
  end
end

navigate(function()
end)

vim.keymap.set("n", "N", function()
  local forward
  if vim.v.searchforward == 1 then
    forward = true
  else
    forward = false
  end
  navigate(function()
    vim.cmd('normal! N')
  end, forward)
end, { silent = true, noremap = true })

vim.keymap.set("n", "n", function()
  local forward
  if vim.v.searchforward == 1 then
    forward = true
  else
    forward = false
  end
  navigate(function()
    vim.cmd('normal! n')
  end, forward)
end, { silent = true, noremap = true })

vim.keymap.set("n", "*", function()
  navigate(function()
    vim.cmd('normal! *')
  end, true)
end, { silent = true, noremap = true })

return {}
