return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "nvim-lua/plenary.nvim",
      },
      {
        'ahmedkhalf/project.nvim',
        config = function()
          require("project_nvim").setup({
            -- line below commented out due to - https://github.com/ahmedkhalf/project.nvim/issues/169
            detection_methods = { "lsp", "pattern" },
            patterns = { ".git", ".gitignore", "README.md", "go.mod", "Makefile" },

            silent_chdir = false,
          })
        end
      },
      {
        "nvim-telescope/telescope-live-grep-args.nvim",
        -- This will not install any breaking changes.
        -- For major updates, this must be adjusted manually.
        -- version = "^1.0.0",
      },
    },
    config = function()
      local ts = require('telescope')
      local previewers = require("telescope.previewers")
      local lga_actions = require("telescope-live-grep-args.actions")
      ts.setup({
        extensions = {
          live_grep_args = {
            auto_quoting = true, -- enable/disable auto-quoting
            mappings = {
              i = {
                ["<C-k>"] = lga_actions.quote_prompt(),
                ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob *." }),
                -- freeze the current list and start a fuzzy search in the frozen list
                ["<C-space>"] = require('telescope.actions').to_fuzzy_refine,
              },
            },
          }
        }
      })


      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
      vim.keymap.set("n", "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
      -- vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
      vim.keymap.set('n', '<leader>fr', builtin.resume, {})

      ts.load_extension("projects")
      ts.load_extension("live_grep_args")
    end
  },
}
