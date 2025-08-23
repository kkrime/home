return {
  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 5000,
      background_colour = "#000000",
      render = "wrapped-compact",
    },
    config = function(_)
      local notify = require("notify")
      vim.notify = notify
      vim.keymap.set("n", "<leader>c", function()
        notify.dismiss({ pending = true, silent = true })
      end)

      vim.keymap.set("n", "<leader>n", function()
        require('telescope').extensions.notify.notify()
      end)

      notify.setup(
        {
          -- background_colour = "NotifyBackground",
          -- fps = 30,
          -- icons = {
          --   DEBUG = "",
          --   ERROR = "",
          --   INFO = "",
          --   TRACE = "✎",
          --   WARN = ""
          -- },
          -- level = 2,
          -- minimum_width = 50,
          -- render = "default",
          stages = "slide",
          -- time_formats = {
          --   notification = "%T",
          --   notification_history = "%FT%T"
          -- },
          -- timeout = 5000,
          -- top_down = true
        }
      )
    end
  },
};
