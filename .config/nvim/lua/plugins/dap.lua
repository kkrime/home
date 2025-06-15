vim.api.nvim_create_user_command("Debug", function(args)
  vim.notify(vim.inspect({ "args", args }))
  vim.cmd('DapUiToggle')
  -- vim.schedule(function()
  -- vim.cmd('DapContinue')
  vim.schedule(function()
    -- local keys = vim.api.nvim_replace_termcodes('Attach', true, false, true)
    -- vim.api.nvim_feedkeys(keys, 't', false)
    -- require("dap.utils").pick_process({ filter = 'zitadel' })
    local dap = require("dap")
    -- vim.notify(vim.inspect({ "dap.adapters", dap.adapters }))
    -- vim.notify(vim.inspect({ "dap.adapters", dap.adapters['go'] }))
    -- vim.notify(vim.inspect({ "dap.configurations", dap.configurations['go'][5] }))

    -- local config = dap.configurations['go'][5]
    -- config.pid = 92853

    -- dap.run(config, { filename = 'go' })

    dap.run({ type = 'go', request = 'attach', mode = 'local', processId = tonumber(args.args) })


    -- local custom_gruvbox = require('lualine.themes.gruvbox')
    -- vim.notify(vim.inspect({ "custom_gruvbox", custom_gruvbox }))

    -- vim.api.nvim_input("Attach<CR>")

    vim.schedule(function()
      local keys = vim.api.nvim_replace_termcodes('1<CR>', true, false, true)
      vim.api.nvim_feedkeys(keys, 'm', false)
    end)
  end)
end, { nargs = 1 })

local target = nil
return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = '#993939', bg = '#31353f' })
      vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg = 0, fg = '#61afef', bg = '#31353f' })
      vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = '#98c379', bg = '#31353f' })

      vim.fn.sign_define('DapBreakpoint',
        { text = '', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
      vim.fn.sign_define('DapBreakpointCondition',
        { text = 'ﳁ', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
      vim.fn.sign_define('DapBreakpointRejected',
        { text = '', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
      vim.fn.sign_define('DapLogPoint', {
        text = '',
        texthl = 'DapLogPoint',
        linehl = 'DapLogPoint',
        numhl =
        'DapLogPoint'
      })
      vim.fn.sign_define('DapStopped', { text = '', texthl = 'DapStopped', linehl = 'DapStopped', numhl = 'DapStopped' })

      -- Debugger
      vim.api.nvim_set_keymap("n", "<leader>dt", ":DapUiToggle<CR>", { noremap = true })
      vim.api.nvim_set_keymap("n", "<S-UP>", ":DapTerminate<CR>", { noremap = true })
      vim.api.nvim_set_keymap("n", "<UP>", ":DapStepOut<CR>", { noremap = true })
      vim.keymap.set("n", "<leader>dd", function()
        local dapui = require("dapui")
        dapui.open()
        vim.cmd('GoEnv .env')

        local dap = require('dap')
        if target == nil then
          local bufnr = vim.api.nvim_get_current_buf()
          local configs = dap.providers.configs
          for _, config in pairs(configs) do
            for _, c in pairs(config(bufnr)) do
              if c.name == "zitadel" then
                vim.notify(vim.inspect({ "c", c }))
                target = c
                break
              end
            end
          end
        end
        if target ~= nil then
          dap.run(target, nil)
        else
          vim.notify("target not found")
        end
      end, { noremap = true })
      vim.api.nvim_set_keymap("n", "<LEFT>", ":DapToggleBreakpoint<CR>", { noremap = true })
      vim.api.nvim_set_keymap("n", "<RIGHT>", ":DapContinue<CR>", { noremap = true })
      vim.api.nvim_set_keymap("n", "<DOWN>", ":DapStepOver<CR>", { noremap = true })
      vim.api.nvim_set_keymap("n", "<S-DOWN>", ":DapStepInto<CR>", { noremap = true })
    end
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      -- "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      require('dapui').setup(
        {
          controls = {
            element = "repl",
            enabled = true,
            icons = {
              disconnect = "",
              pause = "",
              play = "",
              run_last = "",
              step_back = "",
              step_into = "",
              step_out = "",
              step_over = "",
              terminate = ""
            }
          },
          element_mappings = {},
          expand_lines = true,
          floating = {
            border = "single",
            mappings = {
              close = { "q", "<Esc>" }
            }
          },
          force_buffers = true,
          icons = {
            collapsed = "",
            current_frame = "",
            expanded = ""
          },
          layouts = { {
            elements = { {
              id = "scopes",
              size = 0.25
            }, {
              id = "breakpoints",
              size = 0.25
            }, {
              id = "stacks",
              size = 0.25
            }, {
              id = "watches",
              size = 0.25
            } },
            position = "left",
            size = 40
          }, {
            elements = { {
              id = "repl",
              size = 1.0
            }, },
            position = "bottom",
            size = 10
          } },
          mappings = {
            edit = "e",
            expand = { "<CR>", "<2-LeftMouse>" },
            open = "o",
            remove = "d",
            repl = "r",
            toggle = "t"
          },
          render = {
            indent = 1,
            max_value_lines = 100
          }
        }

      )
    end
  },
  {
    "leoluz/nvim-dap-go",
    config = function()
      require('dap-go').setup {
        -- Additional dap configurations can be added.
        -- dap_configurations accepts a list of tables where each entry
        -- represents a dap configuration. For more details do:
        -- :help dap-configuration
        dap_configurations = {
          {
            -- Must be "go" or it will be ignored by the plugin
            type = "go",
            name = "zitadel",
            request = "launch",
            program = "main.go",
            showLog = true,
            args = { 'start-from-init', '--masterkey', 'MasterkeyNeedsToHave32Characters', '--tlsMode', 'disabled' },
            outputMode = "remote",
          },
        },
        -- delve configurations
        delve = {
          -- the path to the executable dlv which will be used for debugging.
          -- by default, this is the "dlv" executable on your PATH.
          path = "dlv",
          -- time to wait for delve to initialize the debug session.
          -- default to 20 seconds
          initialize_timeout_sec = 20,
          -- a string that defines the port to start delve debugger.
          -- default to string "${port}" which instructs nvim-dap
          -- to start the process in a random available port.
          -- if you set a port in your debug configuration, its value will be
          -- assigned dynamically.
          port = "${port}",
          -- additional args to pass to dlv
          args = {},
          -- the build flags that are passed to delve.
          -- defaults to empty string, but can be used to provide flags
          -- such as "-tags=unit" to make sure the test suite is
          -- compiled during debugging, for example.
          -- passing build flags using args is ineffective, as those are
          -- ignored by delve in dap mode.
          -- avaliable ui interactive function to prompt for arguments get_arguments
          build_flags = {},
          -- whether the dlv process to be created detached or not. there is
          -- an issue on delve versions < 1.24.0 for Windows where this needs to be
          -- set to false, otherwise the dlv server creation will fail.
          -- avaliable ui interactive function to prompt for build flags: get_build_flags
          detached = vim.fn.has("win32") == 0,
          -- the current working directory to run dlv from, if other than
          -- the current working directory.
          cwd = nil,
        },
        -- options related to running closest test
        tests = {
          -- enables verbosity when running the test.
          verbose = false,
        },
      }
    end
  },
  {
    'nvim-treesitter/nvim-treesitter', -- {'do': ':TSUpdate'}
  },
  {
    'theHamsta/nvim-dap-virtual-text',
    config = function()
      require('nvim-dap-virtual-text').setup()
    end
  },
}
