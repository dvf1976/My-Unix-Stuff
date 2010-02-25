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
nnoremap  <Up> ""
inoremap  <Up> ""
vnoremap  <Up> ""
snoremap  <Up> ""
" nnoremap! <Up> <Esc>
nnoremap  <Down> ""
inoremap  <Down> ""
vnoremap  <Down> ""
snoremap  <Down> ""
" nnoremap! <Down> <Esc>
nnoremap  <Left> ""
inoremap  <Left> ""
vnoremap  <Left> ""
snoremap  <Left> ""
" nnoremap! <Left> <Esc>
nnoremap  <Right> ""
inoremap  <Right> ""
vnoremap  <Right> ""
snoremap  <Right> ""
" nnoremap! <Right> <Esc>
