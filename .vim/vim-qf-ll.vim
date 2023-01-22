Plugin 'blueyed/vim-qf_resize'

let g:qf_resize_max_height = 1000
let g:qf_resize_max_ratio = 0.25

au FileType qf wincmd J

" close quickfix + locaitonlist buffers
noremap <C-\> :ccl <bar> lcl<CR>
