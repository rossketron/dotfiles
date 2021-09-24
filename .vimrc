" ------------- VIM CONFIGURATION SETTINGS -------------


" ================== General Config ====================

set nocompatible               " this must be first bc changes other options

set t_Co=256                   " enable 256 term color
syntax on                      " turn on syntax highlighting
set noshowmode                 " don't show mode bc airline will
set number relativenumber      " see line numbers relative to current line
set ruler                      " show row,col cursor position in status bar
set novisualbell               " no sounds or bells
set pumheight=10               " max height of completrion menu with C-n
set showcmd                    " show incomplete cmds down the bottom
set cursorline                 " highlight current cursor line

set mouse=a                    " enable mouse use in VIM
set splitbelow                 " put new window below the current when :split
set splitright                 " put new window right of current when :vsplit
set backspace=indent,eol,start " allow backspace in insert mode
set hidden                     " buffers in background without being in window
set clipboard=unnamedplus      " use system clipboard when yanking (not delete)
set history=1000               " store lots of :cmdline history
set viminfo+=n~/.vim/viminfo   " use custom file for viminfo

let mapleader=" "              " set [space] to be new mapleader
set timeoutlen=100             " set timeout btw leader and command

" set cursor to block on normal mode and line on insert
let &t_SI="\<Esc>[6 q"
let &t_EI="\<Esc>[2 q"

" ================== Indentation ======================

set autoindent          " use same indent on new line
set smartindent         " use smart indenting on new line
set smarttab            " insert shiftwidth blanks on <tab>
set shiftwidth=4        " number of spaces for <tab>
set softtabstop=4       " use spaces for tabs
set tabstop=4           " might as well set them all
set expandtab           " use spaces for tabs

" ================== Folds ============================

set nowrap              " dont wrap lines
set linebreak           " wrap lines at convenient points
set foldmethod=indent   " fold based on indent
set foldnestmax=3       " deepest fold is 3 levels
set nofoldenable        " dont fold by default

" ================== Persistent Undo ==================

set noswapfile          " turn off swapfiles
set nobackup            " turn off backups bc implementing our own
set nowb                " turn off backup

" keep undo history across sessions, by storing in file
" only works all the time
if has('persistent_undo') && isdirectory(expand('~').'/.vim/backups')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif

" ================== Completion =======================

" enable ctrl-n and ctrl-p to scroll thru matches
set wildmode=list:longest
set wildmenu                

" list of stuff to ignore when tab completing
set wildignore=*.o,*.obj,*~ 
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=node_modules/**
set wildignore+=*.png,*.jpg,*.gif,*.pdf

" ================== Scrolling ========================

set scrolloff=8       " start vertical scroll at 8 lines top/bottom
set sidescrolloff=15  " start horizontal scroll at 15 cols from margin
set sidescroll=1      " scroll one col at a time

" ================== Search ===========================

set incsearch         " find the next match as we type the search
set ignorecase        " ignore case when searching...
set smartcase         " ...unless we type a capital

" ================== Splitting ========================

let g:netrw_browse_split = 2
let g:vrfr_rg = 'true'
let g:netrw_banner = 0
let g:netrw_winsize = 25

nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
noremap <leader>l :wincmd l<CR>
nnoremap <Leader><CR> :so ~/.vimrc<CR>
nnoremap <Leader><up> :vertical resize +5<CR>
nnoremap <Leader><down> :vertical resize -5<CR>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" ================= Security ==========================

set modelines=0                  " found this recommended
set nomodeline

" ============= VIM-Plug Initialization ===============

:call plug#begin('~/.vim/plugged')
Plug 'vim-utils/vim-man'         " colorize vim man pages
Plug 'sheerun/vim-polyglot'      " better syntax support
Plug 'gruvbox-community/gruvbox' " gruvbox color theme
Plug 'arcticicestudio/nord-vim'   " nord color theme
Plug 'vim-airline/vim-airline'   " airline status bar
call plug#end()

" ================ COLOR SCHEME =======================

set background=dark                     " always use dark bg
let g:gruvbox_contrast_dark = 'medium' " comment to switch theme
colorscheme gruvbox                    " comment to switch theme
"colorscheme nord                      " uncomment to switch theme

" use terminal color for all backgrounds in VIM window
highlight Normal ctermbg=NONE guibg=NONE
highlight SignColumn ctermbg=NONE guibg=NONE
highlight LineNr ctermbg=NONE guibg=NONE

" =============== PLUGIN CONFIGS ======================

" lightgrey column for text at width 80
set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey

" =============== EXTERNAL CONFIGS ====================

source ~/.vim/config/autoclose.vim
source ~/.vim/config/insertLeaderMovements.vim
