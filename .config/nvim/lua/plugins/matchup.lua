return {
  "andymass/vim-matchup",
  event = "BufReadPost",
  config = function()
    -- Enable tree-sitter integration for better context awareness
    vim.g.matchup_matchparen_offscreen = { method = "popup" }
  end,
}
