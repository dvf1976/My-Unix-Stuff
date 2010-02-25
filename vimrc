set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set laststatus=2
set shiftwidth=4
set tabstop=4
set softtabstop=4
set smarttab
set expandtab
set cursorline
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
noremap  <Up> ""
noremap! <Up> <Esc>
noremap  <Down> ""
noremap! <Down> <Esc>
noremap  <Left> ""
noremap! <Left> <Esc>
noremap  <Right> ""
noremap! <Right> <Esc>
