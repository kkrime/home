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
          -- matching parentheses
          highlights.MatchParen = {
            bg = "#ff0000",
            fg = "#FFFFFF",
            bold = true,
          }

          highlights.CurSearch = {
            bg = "#ffffff",
            fg = colors.bg_dark,
            bold = true, -- Bold style
          }

          highlights.Search = {
            bg = colors.warning,
            fg = colors.bg_dark,
            bold = true, -- Bold style
          }

          highlights.TelescopePreviewTitle = {
            fg = colors.red, -- Red matching text
            bold = true,     -- Optional: Add bold styling
          }

          highlights.TelescopePreviewMatch = {
            fg = colors.red, -- Red matching text
            bold = true,     -- Optional: Add bold styling
          }

          highlights.TelescopePreviewLine = {
            -- bg = "#55555e",
            bg = "#55558e",
          }

          highlights.TelescopeMatching = {
            fg = colors.red, -- Red matching text
            bold = true,
          }

          highlights.DiffText = {
            bg = colors.warning,
            fg = "#000000",
          }

          highlights.DiagnosticUnnecessary = {
            bg = "#414868",
          }
        end,
        plugins = {
          telescope = true, -- Ensure Telescope integration is enabled
        },
      })
      vim.cmd [[colorscheme tokyonight]]
    end
  },
};
