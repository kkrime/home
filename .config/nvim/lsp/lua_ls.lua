-- return {
--   vim.notify(vim.inspect({ "INSIDE", INSIDE }))
--   cmd = { 'lua-language-server' },
--   root_dir = util.root_pattern('README.md', ".git", ".gitignore"),

--   settings = {
--     Lua = {
--       diagnostics = {
--         globals = { 'vim' }, -- Fix 'undefined global vim' warnings
--       },
--       workspace = {
--         library = vim.api.nvim_get_runtime_file("", true),
--         checkThirdParty = false,
--       },
--       settings = {
--         Lua = {
--           runtime = {
--             --   --   -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
--             -- version = 'Lua 5.4',
--             version = 'LuaJIT',
--             --   --   -- Setup your lua path
--             path = vim.split(package.path, ';'),
--           },
--           diagnostics = {
--             globals = { "vim" },
--           },
--           workspace = {
--             -- library = { vim.api.nvim_get_runtime_file("lua", true),
--             --   '~/.config/nvim/lua' },
--             -- library = {
--             --   [vim.fn.expand('$VIMRUNTIME/lua')] = true,
--             --   [vim.fn.stdpath('config') .. '/lua'] = true,
--             --   [vim.fn.expand('~/.config/nvim/lua')] = true,
--             -- },
--             -- checkThirdParty = false,
--           },
--           telemetry = {
--             enable = false,
--             -- enable = true,
--           },
--         },
--       },
--     },
--   },

-- }


return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { ".luarc.json", ".luarc.jsonc", ".git", "README.md" },
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT", -- Neovim uses LuaJIT
      },
      diagnostics = {
        globals = { "vim" }, -- Fix "Undefined global 'vim'" warning
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
}
