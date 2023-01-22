Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
let g:fzf_preview_window = ['right:50%', 'ctrl-/']

let g:fzf_preview_window = ['up:40%:hidden', 'ctrl-/']

let g:fzf_preview_window = []

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

nnoremap <C-f> :Rg<CR>
nnoremap <C-l> :Files<CR>
