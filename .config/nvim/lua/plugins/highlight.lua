local function search(direction)
  local matches = vim.fn.getmatches()
  vim.notify(vim.inspect({ "match", matches }))
  local word
  for _, match in pairs(matches) do
    if match.group == "Search" then
      word = match.pattern
    end
  end

  if word ~= nil then
    vim.notify(vim.inspect({ "word", word }))
    vim.fn.setreg('/', word)
  else
    local search_pattern = vim.fn.getreg('/')
    vim.notify(vim.inspect({ "search_pattern", search_pattern }))
  end
  vim.cmd('silent! normal! ' .. direction)
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

local unset_match = function()
  -- NOTE: can get rid of for loop on; https://github.com/neovim/neovim/issues/34999
  for _, winid in pairs(vim.api.nvim_list_wins()) do
    vim.api.nvim_win_call(winid, function()
      vim.cmd("match none")
    end)
  end
end

vim.keymap.set("n", "(", function()
  vim.cmd("nohlsearch")
  -- vim.cmd("match none")
  local word = vim.fn.expand("<cword>")
  -- vim.cmd("match Search /\\<" .. word .. "\\>/")

  -- NOTE: can get rid of for loop on; https://github.com/neovim/neovim/issues/34999
  for _, winid in pairs(vim.api.nvim_list_wins()) do
    vim.api.nvim_win_call(winid, function()
      vim.cmd("match none")
      -- command
      vim.cmd("match Search /\\<" .. word .. "\\>/")
    end)
  end
end, { noremap = true, silent = true })

vim.keymap.set("n", ")", function()
  vim.cmd("nohlsearch")
  -- vim.cmd("match none")
  --
  -- NOTE: can get rid of for loop on; https://github.com/neovim/neovim/issues/34999
  unset_match()
end, { noremap = true, silent = true })

vim.keymap.set("n", "*", function()
  -- vim.cmd("nohlsearch")
  -- vim.cmd("match none")
  --
  -- NOTE: can get rid of for loop on; https://github.com/neovim/neovim/issues/34999
  unset_match()

  -- command
  vim.cmd('normal! *')
end, { noremap = true, silent = true })

vim.keymap.set("n", "#", function()
  -- vim.cmd("nohlsearch")
  -- vim.cmd("match none")
  --
  -- NOTE: can get rid of for loop on; https://github.com/neovim/neovim/issues/34999
  unset_match()

  -- command
  vim.cmd('normal! #')
end, { noremap = true, silent = true })

vim.api.nvim_create_autocmd("CmdlineLeave", {
  pattern = { "/", "?" },
  callback = function()
    local search_term = vim.fn.getcmdline()

    if search_term ~= "" then
      -- NOTE: can get rid of for loop on; https://github.com/neovim/neovim/issues/34999
      unset_match()
    end
  end,
})

return {}
