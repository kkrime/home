return {
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    keys = {
      -- { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      -- { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      -- { "r", mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      -- { "R", mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      {
        "<c-s>",
        mode = { "c" },
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash Search"
      },
    },
    config = function()
      vim.api.nvim_set_hl(0, "FlashLabel", {
        fg = "#ffffff",
        bg = '#000000'
      })
      require("flash").setup({
        modes = {
          -- options used when flash is activated through
          -- a regular search with `/` or `?`
          search = {
            -- when `true`, flash will be activated during regular search by default.
            -- You can always toggle when searching with `require("flash").toggle()`
            enabled = true,
            search = {
              -- `forward` will be automatically set to the search direction
              -- `mode` is always set to `search`
              -- `incremental` is set to `true` when `incsearch` is enabled
            },
          },
        },
        highlight = {
          -- show a backdrop with hl FlashBackdrop
          backdrop = true,
          -- Highlight the search matches
          matches = true,
          -- extmark priority
          priority = 5000,
          groups = {
            match = "FlashMatch",
            current = "FlashCurrent",
            backdrop = "FlashBackdrop",
            label = "FlashLabel",
          },
        },
      })
    end
  },
}
