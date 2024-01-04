" Netrw
let g:netrw_banner = 0
let g:netrw_liststyle = 3

set path+=**
set wildmenu
set wildignore+=**/node_modules/**,*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
" set wildmode=list:longest
" set hidden

" Disable compatilibity with vi
set nocompatible

" Enable file type detection
filetype on

" Enable plugins and load plugin for the detectef file type
filetype plugin on

" Load an indent file for detected filetype
filetype indent on

" Turn syntax highlighting on
syntax on

" Set relative number on
set relativenumber

" Set shift widht to 4 spaces
set shiftwidth=4

" While searching through afile incrementall matching character as we type
set incsearch

" Show the mode you are on
set showmode

" Set the commands to save in history
set history=1000
