set nocompatible
syntax on
set nowrap
set encoding=utf8

" Disable file type for plugins
filetype off

call plug#begin()
Plug 'scrooloose/nerdtree'
Plug 'OmniSharp/omnisharp-vim'

call plug#end()

" Set filetype plugin back to on
filetype plugin on

" Show linenumbers
set number relativenumber
set ruler

" Set proper tabs
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab

" Always display the status line
set laststatus=2

" setup powerline
" python from powerline.vim import setup as powerline_setup
" python powerline_setup()
" python del powerline_setup

" Themes and Styling
" set rtp+=/usr/local/lib/python2.7/dist-packages/powerline/bindings/vim
set t_Co=256
" set background=dark


" let base16colorspace=256
colorscheme desert
let g:spacegray_use_italics = 1
let g:spacegray_underline_search = 1
let g:spacegray_italicize_comments = 1

" setup nerdtree stuff
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" reload dwmblocks if you change the config
autocmd BufWritePost ~/git/dwmblocks/config.h !cd ~/git/dwmblocks/; sudo make install && { killall -q dwmblocks;setsid dwmblocks & }

