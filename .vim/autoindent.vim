Plugin 'Yggdroot/indentLine'
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_color_term = 226

set conceallevel=1
let g:indentLine_conceallevel=1
" au BufRead,BufEnter,BufNewFile * IndentLinesReset

autocmd FileType go set list lcs=tab:\┆\ "(last character is a space...)
autocmd FileType go hi SpecialKey ctermfg=gray
