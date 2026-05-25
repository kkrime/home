-- callbacks = {}
-- loaded = {}

local out = {
  callbacks = {},
  loaded = {},
}

vim.keymap.set({ 'n', 'i' }, "<C-b>", function()
  local cb = out.callbacks[vim.bo.filetype]
  if not cb then
    return
  end

  cb()
end)


return out
