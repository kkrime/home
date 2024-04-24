return {
  {
    -- "fatih/vim-go",
    "ray-x/go.nvim",
    dependencies = {
      {
        "ray-x/guihua.lua",
      },
    },
    config = function()
      require("go").setup()

      vim.keymap.set("n", "<C-b>", function()
        vim.api.nvim_command([[:GoBuild]])
      end
      , { silent = true, noremap = true })

      vim.keymap.set("n", "<C-y>", function()
        vim.api.nvim_command([[:GoTest -F]])
      end
      , { silent = true, noremap = true })

      local format_sync_grp = vim.api.nvim_create_augroup("goimports", {})
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function()
          require('go.format').goimports()
        end,
        group = format_sync_grp,
      })
    end,
    event = { "CmdlineEnter" },
    ft = { "go", 'gomod' },
    build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
  }
}
