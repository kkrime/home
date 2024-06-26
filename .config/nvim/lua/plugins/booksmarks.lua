return {
  {
    'tomasky/bookmarks.nvim',
    after = "telescope.nvim",
    lazy = false,
    event = "BufEnter",
    config = function(_)
      local bm = require "bookmarks"
      local map = vim.keymap.set
      map("n", "mm", bm.bookmark_toggle) -- add or remove bookmark at current line
      map("n", "mi", bm.bookmark_ann)    -- add or edit mark annotation at current line
      map("n", "mx", bm.bookmark_clean)  -- clean all marks in local buffer
      map("n", "mn", bm.bookmark_next)   -- jump to next mark in local buffer
      map("n", "mp", bm.bookmark_prev)   -- jump to previous mark in local buffer
      map("n", "ml", bm.bookmark_list)   -- show marked file list in quickfix window
      bm.setup()
    end
  },
};
