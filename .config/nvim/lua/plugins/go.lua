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
        -- loop though and save .go files only
        for i, buf_hndl in ipairs(vim.api.nvim_list_bufs()) do
          -- file = vim.api.nvim_buf_get_name(buf_hndl)
          fileType = vim.fn.getbufvar(buf_hndl, "&filetype")
          if fileType == "go" then
            vim.api.nvim_buf_call(buf_hndl, function()
                vim.cmd('w')
            end)
          end
        end
        vim.api.nvim_command([[:GoBuild]])
      end, { silent = true, noremap = true })

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
