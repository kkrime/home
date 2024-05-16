-- auto indent on insert
vim.keymap.set('n', 'i', function()
  return string.match(vim.api.nvim_get_current_line(), '%g') == nil
      and 'cc' or 'i'
end, { expr = true, noremap = true })

return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
    config = function()
      local highlight = {
        "RainbowRed",
        "RainbowYellow",
        "RainbowBlue",
        "RainbowOrange",
        "RainbowGreen",
        "RainbowViolet",
        "RainbowCyan",
      }

      local hooks = require "ibl.hooks"
      -- create the highlight groups in the highlight setup hook, so they are reset
      -- every time the colorscheme changes
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#FF2400" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#61AFEF" })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#FF2400" })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#61AFEF" })
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#FF2400" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#61AFEF" })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#FF2400" })
      end)

      require("ibl").setup {
        scope = { highlight = highlight },
      }
      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    end
  },
}
