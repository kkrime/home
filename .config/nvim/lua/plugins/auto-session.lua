-- https://github.com/neovim/neovim/issues/40938
local first = false
vim.api.nvim_create_autocmd("FocusGained", {
  group = my_group,
  pattern = "*", -- Matches all files
  callback = function()
    if first == false then
      first = true
      vim.api.nvim_feedkeys(vim.keycode("<C-w>="), "n", false)
    end
  end,
})

return {
  -- "rmagatti/auto-session",
  'cameronr/auto-session',
  branch = 'shada',
  lazy = false,
  ---enables autocomplete for opts
  ---@module "auto-session"
  ---@type AutoSession.Config
  config = function()
    vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
    require("auto-session").setup({
      save_and_restore_shada = true,
      single_session_mode = true,
    })
  end
}
