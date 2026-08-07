return {
  "rickyelopez/uncrustify.nvim",
  ft = { "c", "cpp" },
  requires = { "nvim-lua/plenary.nvim" },
  config = function()
    local uncrustify = require("uncrustify")
    uncrustify.setup({ format_timeout = 5000 })

    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = { "*.c", "*.cpp" },
      callback = function(args)
        vim.notify("UNCRUST")
        -- uncrustify.format()
      end,
    })
  end,
}
