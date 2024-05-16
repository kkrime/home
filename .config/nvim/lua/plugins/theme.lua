-- return {
--   {
--     "ellisonleao/gruvbox.nvim",
--     priority = 1000,
--     -- opt
--     config = function(_)
--       vim.o.background = "light" -- or "light" for light mode
--       vim.cmd([[colorscheme gruvbox]])
--     end
--   },
-- };

return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    -- opt
    config = function(_)
      vim.opt.termguicolors = true
      require("tokyonight").setup({
        style = "night",
        styles = {
          comments = { italic = true, bold = true },
        },
        sidebars = { "qf", "vista_kind", "terminal", "packer" },
        -- Change the "hint" color to the "orange" color, and make the "error" color bright red
        on_colors = function(colors)
          colors.hint = colors.orange
          colors.error = "#ff0000"
          colors.comment = "#B38B6D"
        end
      })
      vim.cmd [[colorscheme tokyonight]]
    end
  },
};
