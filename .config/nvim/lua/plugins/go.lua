return {
  {
    -- "fatih/vim-go",
    "ray-x/go.nvim",
    dependencies = {
      {
        "ray-x/guihua.lua",
      },
    },
    lazy = true,
    config = function()
      local go = require("go")
      go.setup({
        null_ls = {},
        buildtargets = {
          get_project_root_func = require("project_nvim.project").get_project_root,
          select_buildtarget_callback = require('lualine').refresh,
          close_menu_keys = { '<Esc>', '' }
        }
      })

      local saveAllProjectGoFiles = function()
        local project_dir = require("project_nvim.project").get_project_root()

        -- loop though and save .go files in current project only
        for _, buf_hndl in ipairs(vim.api.nvim_list_bufs()) do
          local file = vim.api.nvim_buf_get_name(buf_hndl)
          local file_in_project = vim.startswith(file, project_dir)

          if file_in_project then
            fileType = vim.fn.getbufvar(buf_hndl, "&filetype")
            if fileType == "go" then
              vim.api.nvim_buf_call(buf_hndl, function()
                vim.cmd('w')
              end)
            end
          end
        end
      end

      -- build
      vim.keymap.set({ 'n', 'i' }, "<C-b>", function()
        saveAllProjectGoFiles()
        vim.api.nvim_command([[:GoBuild %]])
      end, { silent = true, noremap = true })

      -- -- run
      -- local Terminal = require('toggleterm.terminal').Terminal
      -- local goRun    = Terminal:new({
      --   cmd = "go run .",
      --   hidden = true,
      --   close_on_exit = false,
      -- })
      -- vim.keymap.set({ 'n', 'i' }, "<C-r>", function()
      --   saveAllProjectFiles()
      --   goRun:toggle()
      -- end, { silent = true, noremap = true })

      -- test
      vim.keymap.set("n", "<C-y>", function()
        vim.api.nvim_command([[:GoTest -F]])
      end, { silent = true, noremap = true })

      local format_sync_grp = vim.api.nvim_create_augroup("goimports", {})
      -- vim.api.nvim_create_autocmd("BufWritePre", {
      --   pattern = "*.go",
      --   callback = function(args)
      --     vim.notify(vim.inspect({ "args", args }))
      --     require('go.format').goimports()
      --   end,
      --   group = format_sync_grp,
      -- })
    end,
    event = { "CmdlineEnter" },
    ft = { "go", 'gomod' },
    build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
  }
}
