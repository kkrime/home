let g:go_debug_mappings = {
      \ '(go-debug-continue)': {'key': 'c', 'arguments': '<nowait>'},
      \ '(go-debug-next)': {'key': 'n', 'arguments': '<nowait>'},
      \ '(go-debug-step)': {'key': 's'},
      \ '(go-debug-print)': {'key': 'p'},
  \}

let g:go_debug_windows = {
      \ 'goroutines': 'botright 6new',
      \ 'vars':       'rightbelow 50vnew',
      \ 'stack':      'rightbelow 10new',
      \ }


map <leader>ds :GoDebugStart<cr>
map <leader>dt :GoDebugStop<cr>
map <leader>db :GoDebugBreakpoint<cr>
