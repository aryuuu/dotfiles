set nocompatible
filetype off
set number

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
Plugin 'VundleVim/Vundle.vim'

" autocomplete
Plugin 'Valloric/YouCompleteMe'

" add all plugins before the following line
call vundle#end()		" required
filetype plugin indent on	" required


syntax on
" case-insensitive search
set ignorecase
