return {
  'numToStr/Comment.nvim',
  opts = {
    -- add any options here
  },
  lazy = false,
  config = function()
    require('Comment').setup {
      ignore = '^$',
    }

    vim.keymap.set("n", "gcl", function()
      vim.api.nvim_feedkeys("gcc", 'm', false)
    end, { silent = true, noremap = true })

    vim.keymap.set("n", "gcn", function()
      if vim.api.nvim_get_current_line() == "" then
        return
      end
      -- get curosr location
      local row, col = unpack(vim.api.nvim_win_get_cursor(0))
      -- get line
      vim.api.nvim_feedkeys("\"ayy", 'x', true)
      vim.api.nvim_feedkeys("gcl", 'x', true)
      -- paste line
      vim.api.nvim_feedkeys("\"ap", 'x', true)
      -- set curosr location
      vim.api.nvim_win_set_cursor(0, { row + 1, col })
    end, { silent = true, noremap = true })
  end
}
