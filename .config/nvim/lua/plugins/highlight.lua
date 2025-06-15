local function search(direction)
  local match = vim.fn.getmatches()
  if next(match) == nil then
    local search_pattern = vim.fn.getreg('/')
    if search_pattern == '@@' then
      -- return
    end
    vim.cmd('normal! ' .. direction)
  else
    local word = match[1].pattern
    vim.notify(word)
    vim.notify(vim.inspect({ "match[1].pattern", match[1].pattern }))

    vim.notify(vim.inspect({ "word", word }))

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



vim.keymap.set("n", "(", function()
  local word = vim.fn.expand("<cword>")
  vim.cmd("match Search /\\<" .. word .. "\\>/")
end, { noremap = true, silent = true })

vim.keymap.set("n", ")", function()
  vim.cmd("nohlsearch")
  vim.cmd("match none")
end, { noremap = true, silent = true })


return {}
