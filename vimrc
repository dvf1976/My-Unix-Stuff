set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set laststatus=2
set shiftwidth=4
set tabstop=4
set softtabstop=4
set smarttab
set expandtab
if version >= 700
    set cursorline
endif
highlight CursorLine cterm=NONE guibg=lightblue ctermbg=lightgray
set number
iabbrev myAddr 10 Woodsage Ln Durham NC 27713
iabbrev teh the

"Tags file
autocmd FileType tags set﻿ noexpandtab
autocmd FileType tags set nonumber
autocmd FileType tags set wrap

au BufRead,BufNewFile *.t set syntax=perl

:imap <Insert> <Esc>a
filetype on

" Arrow Keys aren't functional
nnoremap  <Up> <nop>
inoremap  <Up> <nop> 
vnoremap  <Up> <nop>
if version >= 700
    snoremap  <Up> <nop> 
endif
" nnoremap! <Up> <Esc>
nnoremap  <Down> <nop> 
inoremap  <Down> <nop>
vnoremap  <Down> <nop>
if version >= 700
    snoremap  <Down> <nop>
endif
" nnoremap! <Down> <Esc>
nnoremap  <Left> <nop>
inoremap  <Left> <nop>
vnoremap  <Left> <nop>
if version >= 700
    snoremap  <Left> <nop>
endif
" nnoremap! <Left> <Esc>
nnoremap  <Right> <nop>
inoremap  <Right> <nop>
vnoremap  <Right> <nop>
if version >= 700
    snoremap  <Right> <nop>
endif
" nnoremap! <Right> <Esc>

function RunMe()
  if filereadable('Makefile')
    "excl.mark = suppress jumping on warr/err
    make!
    " open quickfix window IF there was any error
    cwindow
  else
    " run current file as a script
    !./%
  endif
endfunction

"Make or run on F9
map  <F9>  :w<CR>:call RunMe()<CR>
imap <F9>  <esc>:w<CR>:call RunMe()<CR>

" window
nmap <leader>swh  :topleft  vnew<CR>
nmap <leader>swl :botright vnew<CR>
nmap <leader>swk    :topleft  new<CR>
nmap <leader>swj  :botright new<CR>

" buffer
nmap <leader>sh     :leftabove  vnew<CR>
nmap <leader>sl     :rightbelow vnew<CR>
nmap <leader>sk     :leftabove  new<CR>
nmap <leader>sj     :rightbelow new<CR>

" http://nvie.com/posts/how-i-boosted-my-vim/

" Use pathogen to easily modify the runtime path to include all
" plugins under the ~/.vim/bundle directory
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

let mapleader=","

set backspace=indent,eol,start " allow backspacing over everything in insert mode
set autoindent " always set autoindenting on
set copyindent " copy the previous indentation on autoindenting
set showmatch   " show matching parens
set ignorecase  " ignore case when searching
set smartcase   " ignore case if search pattern is all lowercase, 
                "    case-sensitive otherwise
set hlsearch    " highlight search terms
set incsearch   " show search matches as you type

set history=1000
set undolevels=1000
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                " change the terminal's title
set visualbell           " don't beep
set noerrorbells         " don't beep

set pastetoggle=<F2>

au BufEnter *.cls set syntax=java tabstop=4 shiftwidth=4 softtabstop=4 nowrap
au BufEnter *.cls exec 'match Todo /\%>80v.\+/'
au BufEnter *.trigger set syntax=java tabstop=4 shiftwidth=4 softtabstop=4 nowrap
au BufEnter *.trigger exec 'match Todo /\%>80v.\+/'

