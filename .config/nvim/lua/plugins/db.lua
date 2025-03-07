return {
  {
    "kndndrj/nvim-dbee",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    build = function()
      require("dbee").install()
    end,
    config = function()
      require("dbee").setup({
        default_connection = 'zitadel1',
        result = {
          focus_result = false,
        },
        sources = {
          require("dbee.sources").FileSource:new(vim.fn.expand("$HOME") .. "/.persistence.json"),
        },
      })
    end,
  },
}
