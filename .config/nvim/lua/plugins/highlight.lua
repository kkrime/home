local function search(direction)
  local match = vim.fn.getmatches()
  -- vim.notify(vim.inspect({ "match", match }))
  if next(match) == nil then
    local search_pattern = vim.fn.getreg('/')
    vim.notify(vim.inspect({ "search_pattern", search_pattern }))
    if search_pattern == 'v:null' then
      return
    end
    if search_pattern == '@@' then
      return
    end
    vim.cmd('normal! ' .. direction)
  else
    local word = match[1].pattern
    vim.notify(vim.inspect({ "word", word }))
    if word == nil then
      return
    end
    vim.fn.setreg('/', word)
    vim.cmd('normal! ' .. direction)
  end
end

vim.keymap.set("n", "n", function()
  search('n')
end, { silent = true, noremap = true })

vim.keymap.set("n", "N", function()
  search('N')
end, { silent = true, noremap = true })


-- vim.api.nvim_set_hl(0, "MyHighlight", {
--   fg = "#ffffff", -- white text
--   bg = "#005f87", -- dark blue background
--   bold = true,    -- bold text
--   italic = false,
--   underline = false,
-- })

vim.keymap.set("n", "(", function()
  vim.cmd("nohlsearch")
  -- vim.cmd("match none")
  local word = vim.fn.expand("<cword>")
  vim.cmd("match Search /\\<" .. word .. "\\>/")
  -- vim.cmd("match MyHighlight /\\<" .. word .. "\\>/")
end, { noremap = true, silent = true })

vim.keymap.set("n", ")", function()
  vim.cmd("nohlsearch")
  vim.cmd("match none")
end, { noremap = true, silent = true })

vim.keymap.set("n", "*", function()
  -- vim.cmd("nohlsearch")
  vim.cmd("match none")
  vim.cmd('normal! *')
end, { noremap = true, silent = true })

vim.keymap.set("n", "#", function()
  -- vim.cmd("nohlsearch")
  vim.cmd("match none")
  vim.cmd('normal! #')
end, { noremap = true, silent = true })


return {}
