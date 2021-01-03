"--------------VIM CONFIGURATION SETTINGS-------------------
" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" ================ General Config ====================

set noshowmode
set relativenumber
set ruler
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set visualbell                  "No sounds
set encoding=utf-8
set pumheight=10
set mouse=a
set splitbelow
set splitright
set t_Co=256
set cursorline
set shortmess+=c
set updatetime=300
set clipboard=unnamedplus

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

"turn on syntax highlighting
syntax on

" Change leader to a comma because the backslash is too far away
" That means all \x commands turn into ,x
" The mapleader has to be set before loading all the plugins
let mapleader=" "
set timeoutlen=100

" =============== VIM-Plug Initialization ===============

call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', {'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'sheerun/vim-polyglot'
Plug 'vim-utils/vim-man'
Plug 'tpope/vim-surround'
Plug 'mbbill/undotree'
Plug 'gruvbox-community/gruvbox'
Plug 'sainnhe/gruvbox-material'
Plug 'phanviet/vim-monokai-pro'
Plug 'vim-airline/vim-airline'
Plug 'flazz/vim-colorschemes'
Plug '/home/mpaulson/personal/vim-be-good'
call plug#end()

"==================COLOR SCHEME=======================
let g:gruvbox_contrast_dark = 'hard'
colorscheme gruvbox
set background=dark

"=================PLUGIN CONFIGS==========================
"-lightgrey column for text width
set colorcolumn=100
highlight ColorColumn ctermbg=0 guibg=lightgrey
" --- The Greatest plugin of all time.  I am not bias
let g:vim_be_good_floating = 1

if executable('rg')
    let g:rg_derive_root='true'
endif

let mapleader = " "

let g:netrw_browse_split = 2
let g:vrfr_rg = 'true'
let g:netrw_banner = 0
let g:netrw_winsize = 25

nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <Leader>ps :Rg<SPACE>
nnoremap <C-p> :GFiles<CR>
nnoremap <Leader>pf :Files<CR>
nnoremap <Leader><CR> :so ~/.vimrc<CR>
nnoremap <Leader>+ :vertical resize +5<CR>
nnoremap <Leader>- :vertical resize -5<CR>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Vim with me
nnoremap <leader>vwm :colorscheme gruvbox<bar>:set background=dark<CR>
nmap <leader>vtm :highlight Pmenu ctermbg=gray guibg=gray

" ================ Turn Off Swap Files ==============
set noswapfile
set nobackup
set nowb

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo') && isdirectory(expand('~').'/.vim/backups')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif

" ================ Indentation ======================

set autoindent
set smartindent
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab

filetype plugin on
filetype indent on

set nowrap       "Don't wrap lines
set linebreak    "Wrap lines at convenient points

" ================ Folds ============================

set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

" ================ Completion =======================

set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

" ================ Scrolling ========================

set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" ================ Search ===========================

set incsearch       " Find the next match as we type the search
set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital

" ================ Security ==========================
set modelines=0
set nomodeline

" ==============EXTERNAL CONFIGS======================
source ~/.vim/config/autoclose.vim
source ~/.vim/config/insertLeaderMovements.vim
