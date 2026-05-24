-- auto add import for golang
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function(args)
    require('go.format').goimports()
  end,
})

-- auto format + auto display error diagnostic info on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    -- require('go.format').goimports()
    -- else

    local extension = string.sub(args.file, (#args.file - 2), #args.file)

    if extension ~= ".go" then
      vim.lsp.buf.format()
      local is_location_list_open = vim.fn.getloclist(0, { winid = 0 }).winid ~= 0
      if is_location_list_open then
        vim.api.nvim_command([[:lclose]])
      end

      vim.diagnostic.setloclist({ severity = 1, open = true })

      is_location_list_open = vim.fn.getloclist(0, { winid = 0 }).winid ~= 0

      if is_location_list_open then
        vim.schedule(function()
          vim.api.nvim_command([[:lopen]])
          local keys = vim.api.nvim_replace_termcodes('<CR>', true, false, true)
          vim.api.nvim_feedkeys(keys, 'm', false)
        end)
      else
      end
    end
  end,
})
return {
  {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    "hrsh7th/cmp-nvim-lua",
    'hrsh7th/cmp-cmdline',
    "saadparwaiz1/cmp_luasnip",
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      {
        "L3MON4D3/LuaSnip",
        config = function(_)
          require("luasnip").config.setup({ store_selection_keys = "<A-p>" })
          local ls = require("luasnip") --{{{

          -- require("luasnip.loaders.from_vscode").lazy_load()
          require("luasnip.loaders.from_lua").load({
            fs_event_providers = { libuv = true, autocmd = true },
            paths =
            "~/.config/nvim/lua/snippets/"
          })

          vim.cmd([[command! LuaSnipEdit :lua require("luasnip.loaders.from_lua").edit_snippet_files()]]) --}}}

          -- Virtual Text{{{
          local types = require("luasnip.util.types")
          ls.config.set_config({

            -- history = true,                             --keep around last snippet local to jump back
            -- Below line is commented out due to; https://github.com/hrsh7th/nvim-cmp/issues/1743
            update_events = "TextChanged,TextChangedI", --update changes as you type
            enable_autosnippets = true,
            -- region_check_events = "CursorMoved,CursorHold,InsertEnter",
            region_check_events = "InsertEnter",
            -- delete_check_events = "TextChanged,InsertEnter",
            ext_opts = {
              [types.choiceNode] = {
                active = {
                  virt_text = { { "●", "GruvboxOrange" } },
                },
              },
              -- [types.insertNode] = { active = {
              -- 		virt_text = { { "●", "GruvboxBlue" } },
              -- 	},
              -- },
            },
          }) --}}}

          -- Key Mapping --{{{

          vim.keymap.set({ "i", "s" }, "<c-s>", "<Esc>:w<cr>")
          vim.keymap.set({ "i", "s" }, "<c-u>", '<cmd>lua require("luasnip.extras.select_choice")()<cr><C-c><C-c>')

          vim.keymap.set({ "i", "s" }, "<C- >", function()
            -- if ls.expand_or_jumpable() then
            if ls.expandable() then
              ls.expand()
            elseif ls.jumpable() then
              ls.jump(1)
            end
          end, { silent = true })


          -- vim.keymap.set({ "i", "s" }, "<TAB>", function()
          --   if ls.expand_or_jumpable() then
          --     ls.expand_or_jump()
          --   end
          -- end, { silent = true })
          -- vim.keymap.set({ "i", "s" }, "<C-j>", function()
          -- 	if ls.jumpable() then
          -- 		ls.jump(-1)
          -- 	end
          -- end, { silent = true })

          vim.keymap.set({ "i", "s" }, "<a-k>", function()
            if ls.jumpable(1) then
              ls.jump(1)
            end
          end, { silent = true })

          vim.keymap.set({ "i", "s" }, "<a-j>", function()
            if ls.jumpable(-1) then
              ls.jump(-1)
            end
          end, { silent = true })

          vim.keymap.set({ "i", "s" }, "<a-n>", function()
            if ls.choice_active() then
              ls.change_choice(1)
            else
              -- print current time
              local t = os.date("*t")
              local time = string.format("%02d:%02d:%02d", t.hour, t.min, t.sec)
              print(time)
            end
          end)
          vim.keymap.set({ "i", "s" }, "<a-p>", function()
            if ls.choice_active() then
              ls.change_choice(-1)
            end
          end) --}}}

          -- More Settings --

          vim.keymap.set("n", "<Leader><CR>", "<cmd>LuaSnipEdit<cr>", { silent = true, noremap = true })
          -- vim.cmd([[autocmd BufEnter */snippets/*.lua nnoremap <silent> <buffer> <CR> /-- End Refactoring --<CR>O<Esc>O]])



          vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
            vim.lsp.handlers.hover,
            { border = 'rounded' }
          )


          vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
            vim.lsp.handlers.signature_help,
            { border = 'rounded' }
          )
          -- TODO look into this
          -- break out of snippet mode
          -- cmp = require("cmp")
          -- vim.keymap.set({ "i", "s" }, "<CR>", function()
          --   vim.notify("cmd")
          --   -- vim.print(cmp.visible())
          --   -- if cmp.visible() then
          --   --   return "<CR>"
          --   -- elseif ls.in_snippet() then
          --   --   -- if ls.in_snippet() then
          --   --   vim.print("inside")
          --   --   return "<Esc>o"
          --   -- else
          --   --   vim.print("outside")
          --   --   return "<CR>"
          --   -- end
          -- end, { silent = true, buffer = true, expr = true })
        end
      },
      {
        "MattiasMTS/cmp-dbee",
        ft = "sql", -- optional but good to have
        opts = {},  -- needed
      },
    },
    config = function(_)
      local cmp = require("cmp")
      local ls = require("luasnip")
      cmp.setup({

        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
          end,
        },

        window = {
          -- completion = cmp.config.window.bordered(),
          -- documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          -- ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          -- ['<CR>'] = {
          --   i = function()
          --     vim.notify("new")
          --     if cmp.visible() then
          --       -- vim.notify("1")
          --       cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })
          --       return
          --     elseif ls.in_snippet() then
          --       vim.notify(vim.inspect({ "ls.jumpable(1)", ls.jumpable(1) }))
          --       vim.notify("2")
          --       if ls.jumpable(1) then
          --         ls.jump(1)
          --       end
          --     else
          --       vim.notify("3")
          --       vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, false, true), "n")
          --     end
          --   end,
          -- },
          ['<C-n>'] = {
            i = function()
              if cmp.visible() then
                local behavior
                if ls.in_snippet() then
                  behavior = cmp.SelectBehavior.Select
                else
                  behavior = cmp.SelectBehavior.Insert
                end
                cmp.select_next_item({ behavior = behavior })
              else
                cmp.complete()
              end
            end,
          },
          ['<C-p>'] = {
            i = function()
              local behavior
              if ls.in_snippet() then
                behavior = cmp.SelectBehavior.Select
              else
                behavior = cmp.SelectBehavior.Insert
              end
              if cmp.visible() then
                cmp.select_prev_item({ behavior = behavior })
              else
                cmp.complete()
              end
            end,
          },
        }),

        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'path' },
          { name = 'nvim_lua' },
          { name = 'luasnip' }, -- For luasnip users.
          { name = 'lazydev' },
          { name = "cmp-dbee" },
        }, {
          { name = 'buffer' },
        })
      })

      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' },
        }, {
          { name = 'cmdline' }
        }),
        matching = { disallow_symbol_nonprefix_matching = false }
      })
    end
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "lua_ls", "gopls", "clangd" },
    },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      {
        "neovim/nvim-lspconfig",
        config = function(_)
          local on_attach = require("cmp_nvim_lsp").on_attach
          local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
          local util = require "lspconfig/util"

          -- local lspconfig = require("lspconfig")
          local lspconfig = vim.lsp.config


          -- lspconfig('lua_ls', {
          --   -- on_attach = on_attach,
          --   -- capabilities = capabilities,
          --   root_dir = util.root_pattern(".git", ".gitignore", "README.md"),
          --   root_dir = util.root_pattern('README.md', ".git", ".gitignore"),
          --   settings = {
          --     Lua = {
          --       runtime = {
          --         --   --   -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          --         -- version = 'Lua 5.4',
          --         version = 'LuaJIT',
          --         --   --   -- Setup your lua path
          --         path = vim.split(package.path, ';'),
          --       },
          --       diagnostics = {
          --         globals = { "vim" },
          --       },
          --       workspace = {
          --         -- library = { vim.api.nvim_get_runtime_file("lua", true),
          --         --   '~/.config/nvim/lua' },
          --         -- library = {
          --         --   [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          --         --   [vim.fn.stdpath('config') .. '/lua'] = true,
          --         --   [vim.fn.expand('~/.config/nvim/lua')] = true,
          --         -- },
          --         -- checkThirdParty = false,
          --       },
          --       telemetry = {
          --         enable = false,
          --         -- enable = true,
          --       },
          --     },
          --   },
          -- })
          -- lspconfig('lua_ls', {
          --   cmd = { 'lua-language-server' },
          --   settings = {
          --     Lua = {
          --       diagnostics = {
          --         globals = { 'vim' }, -- Fix 'undefined global vim' warnings
          --       },
          --       workspace = {
          --         library = vim.api.nvim_get_runtime_file("", true),
          --         checkThirdParty = false,
          --       },
          --     },
          --   },
          -- })
          vim.lsp.enable('lua_ls')
          -- vim.notify("afte lua_ls")

          -- lspconfig = require("lspconfig")

          vim.lsp.enable('buf_ls')

          lspconfig('gopls', {
            on_attach = on_attach,
            capabilities = capabilities,
            cmd = { "gopls" },
            filetypes = { "go", "gomod", "gowork", "gotmpl" },
            -- root_dir = util.root_pattern("go.work", "go.mod", ".git"),
            -- root_dir = util.root_pattern("doc.go", "go.mod", "go.work", ".git"),
            root_dir = util.root_pattern("go.mod", "go.work", "doc.go", ".git"),
            -- root_dir = util.root_pattern("go.mod", "go.work", ".git"),
            settings = {
              gopls = {
                -- buildFlags = { "-tags=integration some-other-tags..." },
                -- experimentalWorkspaceModule = true,
                -- expandWorkspaceToModule = true,
                completeUnimported = true,
                usePlaceholders = false,
                analyses = {
                  unusedparams = true,
                },
                -- ["build.experimentalWorkspaceModule"] = true,
                ["formatting.gofumpt"] = true,
                ["staticcheck"] = true,
                ["ui.verboseOutput"] = true,
              },
            },
          })
          vim.lsp.enable('gopls')

          local opts = { buffer = buffer }
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        end,
      },
    },
  },
  {
    "mrcjkb/rustaceanvim",
    version = '^4', -- Recommended
    lazy = false,   -- This plugin is already lazy
    dependencies = {
      {
        "lvimuser/lsp-inlayhints.nvim",
        opts = {}
      },
    },
    config = function(_)
      vim.g.rustaceanvim = {
        -- Plugin configuration
        tools = {
        },
        -- LSP configuration
        server = {
          on_attach = function(client, bufnr)
            -- you can also put keymaps in here
            local
            bufnr = vim.api.nvim_get_current_buf()
            vim.keymap.set(
              "n",
              "<leader>a",
              function()
                vim.cmd.RustLsp('codeAction') -- supports rust-analyzer's grouping
                -- or vim.lsp.buf.codeAction() if you don't want grouping.
              end,
              -- { silent = true, buffer = bufnr }
              {}
            )
            require("lsp-inlayhints").on_attach(client, bufnr)
          end,
          default_settings = {
            -- rust-analyzer language server configuration
            ['rust-analyzer'] = {
              rustfmt = {
                extraArgs = { "--config", "tab_spaces=2" }
              },
            },
          },
        },
      }
    end
  },
  {
    -- -- https://github.com/nvimdev/lspsaga.nvim/blob/main/lua/lspsaga/init.lua
    "glepnir/lspsaga.nvim",
    config = function(_)
      require('lspsaga').setup({
        diagnostic = {
          keys = {
            quit = '<ESC>',
          },
        },
        code_action = {
          keys = {
            quit = '<ESC>',
            exec = '<CR>',
          },
        },
        finder = {
          keys = {
            quit = '<ESC>',
          },
        },
        definition = {
          keys = {
            quit = '<ESC>',
          },
        },
        rename = {
          in_select = false,
          keys = {
            quit = '<ESC>',
          },
        },
        outline = {
          keys = {
            quit = '<ESC>',
          },
        },
        callhierarchy = {
          keys = {
            quit = '<ESC>',
          },
        },
        typehierarchy = {
          keys = {
            quit = '<ESC>',
          },
        },
      })

      -- Key bindings
      vim.keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<CR>", { silent = true, noremap = true })
      -- vim.keymap.set("n", "gh", "<cmd>Lspsaga finder<CR>", { silent = true })
      -- vim.keymap.del("n", "gri")
      -- vim.keymap.del("n", "grr")
      -- vim.keymap.del("n", "gra")
      -- vim.keymap.del("n", "grn")

      vim.keymap.set('n', 'gr', function() require('telescope.builtin').lsp_references() end,
        { noremap = true, silent = true })
      vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<cr>', { silent = true })
      -- vim.keymap.set({ "n", "v" }, "<leader>a", "<cmd>Lspsaga code_action<CR>", { silent = true })
      vim.keymap.set({ "n", "v" }, "<leader>a", vim.lsp.buf.code_action, { silent = true })
      -- vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", { silent = true })
      vim.keymap.set("n", "<leader>rn", function()
        vim.api.nvim_command([[:Lspsaga rename]])
        -- local keys = vim.api.nvim_replace_termcodes('<ESC>A', true, false, true)
        local keys = vim.api.nvim_replace_termcodes('A', true, false, true)
        vim.api.nvim_feedkeys(keys, 'm', false)
      end, { silent = true })

      vim.lsp.set_log_level("INFO")
    end
  },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- Library paths can be absolute
        "~/projects/my-awesome-lib",
        -- Or relative, which means they will be resolved from the plugin dir.
        "lazy.nvim",
        -- It can also be a table with trigger words / mods
        -- Only load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        -- always load the LazyVim library
        "LazyVim",
        -- Only load the lazyvim library when the `LazyVim` global is found
        { path = "LazyVim",            words = { "LazyVim" } },
        -- Load the wezterm types when the `wezterm` module is required
        -- Needs `justinsgithub/wezterm-types` to be installed
        -- { path = "wezterm-types",             mods = { "wezterm" } },
        -- Load the xmake types when opening file named `xmake.lua`
        -- Needs `LelouchHe/xmake-luals-addon` to be installed
        -- { path = "xmake-luals-addon/library", files = { "xmake.lua" } },
      },
      -- always enable unless `vim.g.lazydev_enabled = false`
      -- This is the default
      enabled = function(root_dir)
        return vim.g.lazydev_enabled == nil and true or vim.g.lazydev_enabled
      end,
      -- disable when a .luarc.json file is found
      enabled = function(root_dir)
        return not vim.uv.fs_stat(root_dir .. "/.luarc.json")
      end,
    },
  },
}
