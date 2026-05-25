return {
  {
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

      -- local format_sync_grp = vim.api.nvim_create_augroup("goimports", {})
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
    -- build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
  }
}
