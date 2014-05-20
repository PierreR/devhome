" set guifont=Bitstream\ Vera\ Sans\ Mono\ 11
set guifont=Source\ Code\ Pro\ 10
set guioptions-=T
set guioptions-=m
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=b
set guicursor=n-v-c:block-Cursor
set guicursor+=i:ver25-iCursor/lCursor
highlight iCursor guibg=green
set guicursor+=a:blinkon0

let g:move_map_keys = 0
vmap <C-S-Down> <Plug>MoveBlockDown
vmap <C-S-Up> <Plug>MoveBlockUp
nmap <C-S-Down> <Plug>MoveLineDown
nmap <C-S-Up> <Plug>MoveLineUp
