vim.keymap.set("c", "<C-h>", "<LEFT>")
vim.keymap.set("c", "<C-l>", "<RIGHT>")

-- vim.keymap.set("c", "<C-j>", function()
--   local line = string.len(vim.fn.getcmdline())
--   local pos = vim.fn.getcmdpos()

--   local diff = pos - 1
--   if diff < 1 then
--     return
--   end

--   while (diff ~= 0) do
--     vim.api.nvim_feedkeys(
--       vim.api.nvim_replace_termcodes("<LEFT>", true, false, true),
--       'm', false)
--     diff = diff - 1
--   end
-- end)

-- vim.keymap.set("c", "<C-k>", function()
--   local line = string.len(vim.fn.getcmdline())
--   local pos = vim.fn.getcmdpos()

--   local diff = line - pos + 1
--   if diff < 1 then
--     return
--   end

--   while (diff ~= 0) do
--     vim.api.nvim_feedkeys(
--       vim.api.nvim_replace_termcodes("<RIGHT>", true, false, true),
--       'm', false)
--     diff = diff - 1
--   end
-- end)

vim.keymap.set("n", "<leader>rr", ":%s/")

vim.keymap.set("c", "<C- >", function()
  local line = vim.fn.getcmdline()
  local cmd_start = string.sub(line, 1, 3)
  if cmd_start ~= "%s/" then
    return
  end

  local pos = vim.fn.getcmdpos()

  local before = string.sub(line, 1, pos - 1)

  local after = string.sub(line, pos, -1)

  vim.fn.setcmdline(before .. "\\(\\)" .. after, pos + 2)
end)


vim.keymap.set("c", "<c-.>", function()
  local line = vim.fn.getcmdline()
  local cmd_start = string.sub(line, 1, 3)
  if cmd_start ~= "%s/" then
    return
  end

  local pos = vim.fn.getcmdpos()

  local after = string.sub(line, pos, -1)

  local pos_ = 0
  while true do
    _, pos_ = string.find(after, "\\", pos_ + 1)
    if not pos_ then
      return
    end
    local match = string.sub(after, pos_, pos_ + 1)
    if match == "\\)" or match == "\\(" then
      pos = pos + pos_ + 1
      vim.fn.setcmdline(line, pos)
      return
    end
  end
end)

vim.keymap.set("c", "<c-,>", function()
  local line = vim.fn.getcmdline()
  local cmd_start = string.sub(line, 1, 3)
  if cmd_start ~= "%s/" then
    return
  end

  local pos = vim.fn.getcmdpos()

  local before = string.sub(line, 1, pos - 1)

  local offset = 0

  local pos_
  while true do
    pos_, offset, _ = string.find(before, "\\", offset + 1)
    if not pos_ then
      break
    end
    local match = string.sub(before, pos_, pos_ + 1)
    if match == "\\)" or match == "\\(" then
      pos = pos_
    end
  end

  if pos then
    vim.fn.setcmdline(line, pos)
  end
end)

return {}
