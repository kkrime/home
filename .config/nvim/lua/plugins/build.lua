callbacks = {}

vim.keymap.set({ 'n', 'i' }, "<C-b>", function()

  local cb = callbacks[vim.bo.filetype]
  if not cb then
    return
  end

  cb()
end)


return callbacks
