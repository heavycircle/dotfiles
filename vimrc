" ~/.vimrc
" For when I don't have Neovim
" author: echoscorpion

" The Basics
set autoread
set mouse="a"

" Line Numbers
set number
set relativenumber

" Indentation (4 spaces)
set autoindent
set expandtab
set smartindent
set shiftwidth=4
set tabstop=4

" Scrolling (8 lines)
set scrolloff=8
set sidescrolloff=8

" History
set undodir=/home/user/.vim/undodir
set undofile
set undolevels=1000
set updatetime=200

" Syntax
filetype plugin indent on
syntax enable

" Searching
set hlsearch
set incsearch

" match-it.vim plugin (%)
runtime macros/matchit.vim
