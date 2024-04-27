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
    end
    , { silent = true, noremap = true })
  end
}
