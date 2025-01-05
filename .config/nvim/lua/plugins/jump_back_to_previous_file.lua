-- clear jumplist
vim.api.nvim_create_autocmd("VimEnter", {
  pattern = "*",
  callback = function()
    for _, winid in pairs(vim.api.nvim_list_wins()) do
      vim.api.nvim_win_call(winid, function()
        vim.cmd('clearjumps')
      end)
    end
  end
})

vim.keymap.set("n", '<C-]>',
  function()
    local jumplist, idx = unpack(vim.fn.getjumplist(vim.fn.winnr()))

    local current_buf = vim.api.nvim_get_current_buf()
    local jump = 1

    while (idx ~= 0)
    do
      if jumplist[idx].bufnr ~= current_buf then
        vim.api.nvim_input(jump .. '<C-o>')
        return
      end
      jump = jump + 1
      idx = idx - 1
    end
  end)

return {}
