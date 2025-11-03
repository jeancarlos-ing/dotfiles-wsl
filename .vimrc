set encoding=utf-8
scriptencoding utf-8

filetype plugin indent on
syntax enable

set t_Co=256
set laststatus=2
set splitbelow splitright
set numberwidth=2
set timeoutlen=500
set updatetime=800
set clipboard=unnamed
set clipboard=unnamedplus
set noswapfile
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set matchpairs+=<:>,[:]
set number relativenumber
set ignorecase smartcase
set fileencoding=utf-8
set linebreak
set wildmode=list:full
set cursorline
set colorcolumn=80
set scrolloff=3
set fileformats=unix,dos
set concealcursor=nc
set confirm
set novisualbell noerrorbells
set history=500
set autowrite
set title
set titlestring=
set titlestring+=%(%{hostname()}\ \ %)
set titlestring+=%(%{expand('%:p')}\ \ %)
set titlestring+=%{strftime('%Y-%m-%d\ %H:%M',getftime(expand('%')))}
set completeopt+=menuone
set completeopt-=preview
set pumheight=15
set shiftround
set virtualedit=block
set tildeop
set nojoinspaces
set synmaxcol=500
set incsearch
set wildmenu
set cursorcolumn

call plug#begin('~/.vim/plugged')
  Plug 'gmarik/Vundle.vim'
  Plug 'itchyny/lightline.vim'
  Plug 'morhetz/gruvbox'
  Plug 'shinchu/lightline-gruvbox.vim'
  Plug 'suan/vim-instant-markdown', {'rtp': 'after'}
  Plug 'frazrepo/vim-rainbow'
  Plug 'scrooloose/nerdtree'                         "
  Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
  Plug 'ryanoasis/vim-devicons'
  Plug 'vimwiki/vimwiki'
  Plug 'jreybert/vimagit'
  Plug 'tpope/vim-surround'
  Plug 'junegunn/goyo.vim'
  Plug 'junegunn/limelight.vim'
  Plug  'junegunn/vim-emoji'
call plug#end()

colorscheme gruvbox
set background=dark
let g:lightline = {}
let g:lightline.colorscheme = 'gruvbox'
let g:gruvbox_contrast_dark='hard'
