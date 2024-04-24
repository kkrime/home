function ToggleQuickFix()
  if vim.fn.getqflist({ winid = 0 }).winid > 0 then
    vim.api.nvim_command([[:copen]])
  else
    vim.api.nvim_command([[:cclose]])
  end
end

return {
  {
    "kevinhwang91/nvim-bqf",
    config = function()
      vim.keymap.set("n", "<C-\\>", "<cmd>cclose<CR>", { silent = true, noremap = true })
      vim.keymap.set("n", "<C-f>", function()
        ToggleQuickFix()
      end, { silent = true, noremap = true })
      require('bqf').setup()
    end
  },
}
