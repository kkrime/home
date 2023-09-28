" Plugin 'fatih/vim-go'

" filetype plugin on
" autocmd FileType go setlocal expandtab

" let g:go_bin_path = $HOME."/go/bin"
" let g:go_fmt_command = "goimports"

nmap <leader>n <plug>(coc-diagnostic-next-error)
nmap <leader>p <plug>(coc-diagnostic-prev-error)

nnoremap <C-b> :GoBuild<CR>
nnoremap <C-y> :GoTest<CR>
