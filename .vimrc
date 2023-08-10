syntax on

" leader key 
let mapleader = " "

" Pluings 
source ~/.vim/vundle.vim
source ~/.vim/commentry.vim
source ~/.vim/coc.vim
source ~/.vim/vim-go.vim
source ~/.vim/vim-go-debug.vim
source ~/.vim/autoindent.vim
source ~/.vim/vim-airline.vim
source ~/.vim/auto-pairs.vim
source ~/.vim/vim-surround.vim
source ~/.vim/debug-mappings.vim
source ~/.vim/ultisnips.vim
source ~/.vim/fzf.vim
source ~/.vim/vim-qf-ll.vim
source ~/.vim/vim-bookmarks.vim
source ~/.vim/typescript.vim

" highlight search results
set hlsearch

" disbale .swp file creation/check
set noswapfile

" set tab
set tabstop=4
set shiftwidth=4
set expandtab 
set autoindent
set smartindent

" show linenumber
set nu

" fixes unable to delete past point of insert issue
set backspace=indent,eol,start
