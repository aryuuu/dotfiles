set nocompatible
filetype off
set number
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent


syntax on
" case-insensitive search
set ignorecase
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O
