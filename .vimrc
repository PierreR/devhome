set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Plugin 'gmarik/vundle'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'bling/vim-airline'
"this plugin stole <TAB> ...
"Plugin 'SirVer/ultisnips'
Plugin 'scrooloose/syntastic'
Plugin 'dag/vim2hs'
Plugin 'eagletmt/neco-ghc'
Plugin 'godlygeek/tabular'
Plugin 'Shougo/neocomplcache.vim'
"Plugin 'ervandew/supertab'
Plugin 'eagletmt/ghcmod-vim'
"Plugin 'Valloric/YouCompleteMe'
" Dependency of ghcmod-vim
Plugin 'Shougo/vimproc'
Plugin 'rodjek/vim-puppet'
Plugin 'matze/vim-move'
Plugin 'vim-scripts/tComment'
Plugin 'scrooloose/nerdtree'

filetype plugin indent on

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
set noexpandtab "don't transform tab into spaces by default
set incsearch
"set lazyredraw
set mouse=a " enable the mouse in all mode
set nobackup
set nocompatible
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
set wildignore+=*.pyc,*.jar,*.pdf,*.class,/tmp/*.*,.git,*.o,*.obj,*.png,*.jpeg,*.gif,*.orig,target/*,*.6,*.a,*.out,*.hi

" Nice to have
set laststatus=2
set titlestring=%f title
set wildmenu
set wildmode=longest,list
set tags=tags;/,codex.tags;/
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
nnoremap <C-s> :wa<CR>
inoremap <C-s> <Esc>:w<CR>i
nnoremap <F4> :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>
nnoremap <F5> :buffers<CR>:buffer<Space>
noremap <Space> :set hlsearch! hlsearch?<CR>
noremap <leader>n :cn<CR>
nnoremap <leader>l :execute ToggleColorScheme()<CR>
nnoremap <leader>s :%s/\s\+$//e<CR>
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
map <leader>t :NERDTreeToggle<CR>
"autocmd FileType haskell nnoremap <silent><F2> :GhcModType<CR>:sleep 5<CR>:GhcModTypeClear<CR>
autocmd FileType haskell nnoremap <silent><F2> :GhcModType<CR>
autocmd FileType haskell nnoremap <silent><F3> :GhcModTypeClear<CR>
autocmd FileType haskell set expandtab
autocmd FileType cabal set expandtab
"   Correct some spelling mistakes
ia htis     this
ia tihs     this
ia funciton function
ia fucntion function
ia funtion  function
ia retunr   return
ia reutrn   return

hi CursorLine   cterm=NONE ctermbg=254

" Persistent-undo (vim 7.3)
set undofile
set undodir=/tmp

"let g:SuperTabDefaultCompletionType = "context"

set wildchar=<Tab> wildmenu wildmode=full

au FileType haskell setlocal foldmethod=manual
au FileType haskell setlocal omnifunc=necoghc#omnifunc
au BufNewFile,BufRead *.hs,*.hsc,*.lhs,*.dump-simpl set filetype=haskell
au BufNewFile,BufRead *.lhs set syntax=lhaskell

let g:ghcmod_hlint_options = ['--ignore=Avoid lambda']
let g:airline#extensions#tabline#enabled     = 1
let g:haskell_conceal                        = 0
let g:acp_enableAtStartup                    = 0
let g:neocomplcache_enable_at_startup        = 1
let g:loaded_syntastic_puppet_puppet_checker = 0

if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif

"let g:ycm_filetype_specific_completion_to_disable = {'haskell' : 1}

autocmd BufWritePre *.pp :%s/\s\+$//e

let g:ctrlp_working_path_mode = 'a'
