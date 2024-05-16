return {
  {
    "windwp/nvim-ts-autotag",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require('nvim-ts-autotag').setup()
    end,
  },
}
