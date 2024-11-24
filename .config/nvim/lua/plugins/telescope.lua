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
            -- detection_methods = { "pattern", "lsp" },
            patterns = { ".git", ".gitignore", "README.md", "go.mod", "Makefile" },

            silent_chdir = false,
          })
        end
      },
    },
    config = function()
      local ts = require('telescope')
      ts.load_extension("projects")

      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
    end
  },
}
