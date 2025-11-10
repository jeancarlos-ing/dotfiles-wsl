:w:wptencoding utf-8

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
