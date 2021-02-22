call plug#begin('~/.vim/plugged')
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'christoomey/vim-system-copy'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'scrooloose/nerdcommenter'
  Plug 'scrooloose/nerdtree'
  Plug 'ntpeters/vim-better-whitespace'
  Plug 'tpope/vim-fugitive'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

  Plug 'leafgarland/typescript-vim'
  Plug 'yuezk/vim-js'
  Plug 'maxmellon/vim-jsx-pretty'
  Plug 'peitalin/vim-jsx-typescript'

  Plug 'joshdick/onedark.vim'
call plug#end()

if &term =~ '256color'
    " disable Background Color Erase (BCE) so that color schemes
    " render properly when inside 256-color tmux and GNU screen.
    " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
    set t_ut=
endif

colorscheme onedark
let g:airline_theme='onedark'

filetype plugin indent on
syntax enable

set autoread
set expandtab
set hlsearch
set lazyredraw
set nocompatible
set noswapfile
set number
set smarttab

set background=dark
set backspace=2
set encoding=UTF-8
set guioptions-=e
set laststatus=2
set shiftwidth=2
set showtabline=2
set softtabstop=2
set tabstop=2
set timeoutlen=1000
set ttimeoutlen=0
set undodir=~/.vim/undodir
set undofile

let g:coc_global_extensions = ['coc-tsserver', 'coc-prettier', 'coc-eslint']

" setup cursor to blink and such
let &t_SI = "\033[5 q"
let &t_EI = "\033[1 q"

" ctrlp
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif
let g:ctrlp_working_path_mode='w'
let g:ctrlp_show_hidden = 1

" nerdtree
let g:NERDTreeNodeDelimiter = "\u00a0"
let NERDTreeShowHidden=1

let mapleader=","
nmap <Leader>n :NERDTreeToggle<CR>
nmap <Leader>p :CtrlP<CR>
nmap <Leader>e :CocDiagnostics<CR>
nmap <Leader>r :CocCommand eslint.executeAutofix<CR>
nmap <Leader>d :call CocAction('jumpDefinition', 'drop')<CR>
nmap <Leader>h :call CocAction('doHover')<CR>
nmap <Leader>j <Plug>(coc-diagnostic-next)

autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact

command! -nargs=0 Prettier :CocCommand prettier.formatFile

nmap <Tab> :b#<CR>
