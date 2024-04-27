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
          require("project_nvim").setup()
        end
      },
    },
    config = function()
      local ts = require('telescope')
      ts.load_extension("projects")

      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
      vim.keymap.set('n', '<leader>rg', builtin.live_grep, {})
    end
  },
}
