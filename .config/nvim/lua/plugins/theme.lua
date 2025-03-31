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
    config = function(_)
      vim.opt.termguicolors = true
      require("tokyonight").setup({
        style = "night",
        styles = {
          comments = { italic = true, bold = true },
        },
        sidebars = { "qf", "vista_kind", "terminal", "packer" },
        on_colors = function(colors)
          colors.hint    = colors.orange
          colors.error   = "#ff0000"
          colors.comment = "#B38B6D"
        end,
        on_highlights = function(highlights, colors)
          highlights.MatchParen = { bg = "#ff0000", fg = "#FFFFFF", bold = true }

          highlights.DiffText = {
            bg = colors.warning,
            fg = "#000000",
          }
        end,
      })
      vim.cmd [[colorscheme tokyonight]]
    end
  },
};
