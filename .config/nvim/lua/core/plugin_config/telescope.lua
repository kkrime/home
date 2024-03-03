local ts = require('telescope')

ts.setup({
  extensions = {
    rooter = {
      enable = true,
      patterns = { ".git" },
      debug = false
    }
  }
})

ts.load_extension("rooter")

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>rg', builtin.live_grep, {})
