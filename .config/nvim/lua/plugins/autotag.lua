return {
  {
    "windwp/nvim-ts-autotag",
    -- version = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
      require('nvim-ts-autotag').setup({
        -- filetypes = { "html", "xml" },
      })
    end,
  },
}
