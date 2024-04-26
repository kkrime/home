vim.keymap.set("v", "<C-c>", function()
  vim.api.nvim_feedkeys("\"+y", 'm', false)
end, { silent = true })

return {}
