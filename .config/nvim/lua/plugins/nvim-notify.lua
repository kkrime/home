return {
  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 5000,
      background_colour = "#000000",
      render = "wrapped-compact",
    },
    config = function(_)
      vim.notify = require("notify")
      -- require("notify")("My super important message")
    end
  },
};
