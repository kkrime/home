vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.backspace = '2'
vim.opt.showcmd = true
vim.opt.laststatus = 2
vim.opt.autowrite = true
vim.opt.cursorline = true
vim.opt.autoread = true

-- use spaces for tabs and whatnot
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab = true

vim.cmd [[ set noswapfile ]]

--Line numbers
vim.wo.number = true

-- don't comment out new line
-- see https://neovim.discourse.group/t/options-formatoptions-not-working-when-put-in-init-lua/3746/4
-- commented out /opt/homebrew/Cellar/neovim/0.10.2_1/share/nvim/runtime/ftplugin/lua.vim line 20
vim.cmd [[ set formatoptions=q ]]
