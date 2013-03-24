" Common usual options that should never be changed.
" Without these you don't survive Vim
syn on

set bs=indent,eol,start
set complete=.,w,b,t "completion will first search in the current buffer, then windows, then open buffers, then tags
set completeopt=menu,longest
set cpoptions+=$ " Display a $ as vi does whenever you use the change command (c)
set cursorline
set directory=~/tmp
set enc=utf-8
set gdefault " assume the /g flag on :s substitutions to replace all matches in a line
set hidden " allow buffer to have hidden changed
set history=50 " how much line do you want to keep in the history table
set ignorecase
set incsearch
set lazyredraw
set mouse=a " enable the mouse in all mode
set nobackup
set nocompatible
set noexpandtab "don't transform tab into spaces by default
set noshowmode
set nostartofline
set noswapfile
set nu
set sessionoptions-=options
set shell=zsh
set shiftwidth=4
set showcmd
set smartcase
set t_Co=256
set tabstop=4
set textwidth=0 " disable automatic line break !
set viminfo='50,<100,s100,%
set wildcharm=<C-Z>
set wildignore+=*.pyc,*.jar,*.pdf,*.class,/tmp/*.*,.git,*.o,*.obj,*.png,*.jpeg,*.gif,*.orig,target/*,*.6,*.a,*.out

" Nice to have
set laststatus=2 
set titlestring=%f title
set wildmenu
set wildmode=longest,list  
set tags+=./tags
set grepprg=ack

let g:netrw_list_hide= '.*\.swp$,.*\.orig$,*\.pyc'
let g:netrw_preview   = 1
let g:netrw_altv = 1
"Mappings
nmap <F1> <nop>
nmap <T-F1> <nop>
imap <F1> <nop>
imap <T-F1> <nop>
let mapleader = ","
let maplocalleader = ","
nnoremap <leader><leader> :LustyBufferExplorer<CR> 
nnoremap Y y$
noremap <C-s> :w<CR> 
inoremap <C-s> <Esc>:w<CR>i
nnoremap <F5> :buffers<CR>:buffer<Space>
noremap <Space> :set hlsearch! hlsearch?<CR>
noremap <leader>n :cn<CR>
nnoremap <leader>l :execute ToggleColorScheme()<CR> 

"   Correct some spelling mistakes
ia htis     this
ia tihs     this
ia funciton function
ia fucntion function
ia funtion  function
ia retunr   return
ia reutrn   return

hi CursorLine   cterm=NONE ctermbg=236 

" Persistent-undo (vim 7.3)
set undofile
set undodir=/tmp

let g:SuperTabDefaultCompletionType = "context"

set wildchar=<Tab> wildmenu wildmode=full
