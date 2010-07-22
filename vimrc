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
if version >= 700
    snoremap  <Up> ""
endif
" nnoremap! <Up> <Esc>
nnoremap  <Down> ""
inoremap  <Down> ""
vnoremap  <Down> ""
if version >= 700
    snoremap  <Down> ""
endif
" nnoremap! <Down> <Esc>
nnoremap  <Left> ""
inoremap  <Left> ""
vnoremap  <Left> ""
if version >= 700
    snoremap  <Left> ""
endif
" nnoremap! <Left> <Esc>
nnoremap  <Right> ""
inoremap  <Right> ""
vnoremap  <Right> ""
if version >= 700
    snoremap  <Right> ""
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
nmap <leader>sh   :leftabove  vnew<CR>
nmap <leader>sl  :rightbelow vnew<CR>
nmap <leader>sk     :leftabove  new<CR>
nmap <leader>sj   :rightbelow new<CR>
