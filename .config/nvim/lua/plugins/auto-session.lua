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
  "rmagatti/auto-session",
  lazy = false,

  ---enables autocomplete for opts
  ---@module "auto-session"
  ---@type AutoSession.Config
  config = function()
    require("auto-session").setup({
      -- auto_restore = false,
      suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
      no_restore_cmds = {
        function(_)
          vim.cmd('windo clearjumps')
        end
      },
      -- post_restore_cmds = {
      --   function(_)
      --     vim.notify("POST")
      --     vim.cmd("wincmd =")
      --   end
      -- },
    })
  end
}
