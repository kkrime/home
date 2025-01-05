vim.keymap.set("n", "<C-h>", function()
  -- vim.cmd("silent! lua vim.api.nvim_win_close(4445, true)")
  require("go.buildtargets").select_buildtarget()
  -- require("go.buildtargets")._show_menu()

  -- local close_menu_key = { '<Esc>' }
  -- for _, i in pairs(close_menu_key) do
  --   vim.notify(vim.inspect({ i = i }))
  -- end
end)

return {}
