-- clear jumplist
vim.api.nvim_create_autocmd("VimEnter", {
  pattern = "*",
  command = "clearjumps",
})

vim.keymap.set("n", "<C-]>",
  function()
    local jumplist, idx = unpack(vim.fn.getjumplist(vim.fn.winnr()))

    local current_buf = vim.api.nvim_get_current_buf()
    local jump = 1

    while (idx ~= 0)
    do
      if jumplist[idx].bufnr ~= current_buf then
        for _ = 1, jump do
          vim.api.nvim_input('<C-o>')
        end
        return
      end
      jump = jump + 1
      idx = idx - 1
    end
  end)

return {}
