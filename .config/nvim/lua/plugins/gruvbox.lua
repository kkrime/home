return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    -- opt
    config = function(_)
      vim.o.background = "light" -- or "light" for light mode
      vim.cmd([[colorscheme gruvbox]])
    end
  },
};
