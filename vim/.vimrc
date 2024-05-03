set nocompatible
filetype off
set number
set relativenumber
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set clipboard+=unnamedplus
set smartcase
set noswapfile
set nobackup
set scrolloff=8
set showmode

syntax on
" case-insensitive search
set ignorecase

" inoremap " ""<left>
" inoremap ' ''<left>
" inoremap ( ()<left>
" inoremap [ []<left>
" inoremap { {}<left>
" inoremap {<CR> {<CR>}<ESC>O
" inoremap {;<CR> {<CR>};<ESC>O

" keymaps
"" normal mode
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

nnoremap n nzz
nnoremap N Nzz

"" insert mode
inoremap jk <ESC>

"" visual mode
vnoremap < <gv
vnoremap > >gv
