local term = vim.env.TERM

vim.notify(vim.inspect({ "term", term }))

if term == "tmux-256color" then
  local lines = tonumber(vim.env.LINES_)
  local columns = tonumber(vim.env.COLUMNS_)

  if lines ~= nil and columns ~= nil then
    vim.o.lines = lines
    vim.o.columns = columns
  end
end
