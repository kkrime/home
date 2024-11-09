return {
  {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-nvim-lsp",
    'hrsh7th/cmp-cmdline',
    "saadparwaiz1/cmp_luasnip",
  },
  {
    'hrsh7th/nvim-cmp',
    config = function(_)
      local cmp = require("cmp")
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
          ['<C-n>'] = {
            i = function()
              if cmp.visible() then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
              else
                cmp.complete()
              end
            end,
          },
          ['<C-p>'] = {
            i = function()
              if cmp.visible() then
                cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
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
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        }),
        matching = { disallow_symbol_nonprefix_matching = false }
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "williamboman/mason-lspconfig.nvim",
        dependencies =
        {
          "williamboman/mason.nvim",
          config = function(_)
            require("mason").setup()
          end
        },
        config = function(_)
          require("mason-lspconfig").setup()
        end
      },
    },
    config = function(_)
      local on_attach = require("cmp_nvim_lsp").on_attach
      local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
      local util = require "lspconfig/util"

      local lspconfig = require("lspconfig")

      lspconfig.lua_ls.setup {
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = {
                [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                [vim.fn.stdpath "config" .. "/lua"] = true,
              },
            },
          },
        }
      }

      lspconfig.clangd.setup {
        capabilities = capabilities,
        cmd = { "clangd" },
        filetypes = { "c", "h", "cpp", "proto" },
        root_dir = util.root_pattern(
          '.clangd',
          '.clang-tidy',
          '.clang-format',
          'compile_commands.json',
          'compile_flags.txt',
          'configure.ac',
          '.git'
        ),
      }

      lspconfig.gopls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = { "gopls" },
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
        root_dir = util.root_pattern("go.work", "go.mod", ".git", ".gitignore"),
        settings = {
          gopls = {
            buildFlags = { "-tags=integration some-other-tags..." },
            completeUnimported = true,
            usePlaceholders = false,
            analyses = {
              unusedparams = true,
            },
            -- ["build.experimentalWorkspaceModule"] = true,
            -- ["formatting.gofumpt"] = true,
            ["staticcheck"] = true,
            ["ui.verboseOutput"] = true,
          },
        },
      }

      lspconfig.html.setup({
        capabilities = capabilities,
        init_options = {
          configurationSection = { "html", "css", "javascript" },
          embeddedLanguages = {
            css = true,
            javascript = true,
          },
          provideFormatter = true,
        },
      })

      -- lspconfig.rust_analyzer.setup({
      --   on_attach = on_attach,
      --   settings = {
      --     ["rust-analyzer"] = {
      --       imports = {
      --         granularity = {
      --           group = "module",
      --         },
      --         prefix = "self",
      --       },
      --       cargo = {
      --         buildScripts = {
      --           enable = true,
      --         },
      --       },
      --       procMacro = {
      --         enable = true
      --       },
      --       rustfmt = {
      --         extraArgs = { "--config", "tab_spaces=2" }
      --       },
      --     },
      --   },
      -- })

      -- auto format on save
      vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]

      local opts = { buffer = buffer }
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    end
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
              { silent = true, buffer = bufnr }
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
      vim.keymap.set("n", "gr", "<cmd>Lspsaga finder<CR>", { silent = true })
      vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<cr>', { silent = true })
      vim.keymap.set({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>", { silent = true })
      -- vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", { silent = true })
      vim.keymap.set("n", "<leader>rn", function()
        vim.api.nvim_command([[:Lspsaga rename]])
        -- local keys = vim.api.nvim_replace_termcodes('<ESC>A', true, false, true)
        local keys = vim.api.nvim_replace_termcodes('A', true, false, true)
        vim.api.nvim_feedkeys(keys, 'm', false)
      end, { silent = true })
    end
  },
}
