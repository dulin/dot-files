colorscheme euphrasia
"colorscheme candystripe

set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
                
"set encoding=latin2
"set fileencoding=latin2
"set fileencodings=latin2

filetype plugin on
filetype indent on
filetype on
syntax on
set autoindent
set hlsearch
set ignorecase
set incsearch

set statusline=
set statusline+=%f\ %2*%m\ %1*%h
set statusline+=%#warningmsg#
set statusline+=%*
set statusline+=%r%=[%{&encoding}\ %{&fileformat}\ %{strlen(&ft)?&ft:'none'}]\ %12.(%c:%l/%L%)
set laststatus=2

set nocompatible
set bs=2
set cursorline
set number
set showbreak=↪

set ruler
set showcmd
set softtabstop=4
set shiftwidth=4
set tabstop=4
set expandtab

map <F11> :!php -q %<CR>
map <F10> :wq!<CR>
map <F2> :w!<CR>
set background=dark
