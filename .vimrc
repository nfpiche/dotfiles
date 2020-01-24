" Plugins
call plug#begin('~/.vim/plugged')
  " NTH plugins
  Plug 'ambv/black'
  Plug 'arcticicestudio/nord-vim'
  Plug 'christoomey/vim-system-copy'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'itchyny/lightline.vim'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'ntpeters/vim-better-whitespace'
  Plug 'pseewald/vim-anyfold'
  Plug 'ryanoasis/vim-devicons'
  Plug 'scrooloose/nerdcommenter'
  Plug 'scrooloose/nerdtree'
  Plug 'tpope/vim-fugitive'
  Plug 'w0rp/ale'
  Plug 'wakatime/vim-wakatime'

  " Language plugins
  Plug 'JamshedVesuna/vim-markdown-preview'
  Plug 'Quramy/tsuquyomi'
  Plug 'burner/vim-svelte'
  Plug 'chemzqm/vim-jsx-improve'
  Plug 'elixir-editors/vim-elixir'
  Plug 'elzr/vim-json'
  Plug 'fatih/vim-go'
  Plug 'hdima/python-syntax'
  Plug 'jdonaldson/vaxe'
  Plug 'leafgarland/typescript-vim'
  Plug 'pangloss/vim-javascript'
  Plug 'prettier/vim-prettier'
  Plug 'rust-lang/rust.vim'
  Plug 'slashmili/alchemist.vim'
call plug#end()

if &term =~ '256color'
    " disable Background Color Erase (BCE) so that color schemes
    " render properly when inside 256-color tmux and GNU screen.
    " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
    set t_ut=
endif
colorscheme nord

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
set undofile

set background=dark
set backspace=2
set encoding=UTF-8
set foldlevel=99
set foldmethod=indent
set guioptions-=e  " Don't use GUI tabline
set laststatus=2
set shiftwidth=2
set showtabline=2  " Show tabline
set softtabstop=2
set statusline+=%m%m%m
set tabstop=2
set timeoutlen=1000
set ttimeoutlen=0
set undodir=~/.vim/undodir

let g:netrw_liststyle=3
let g:jsx_ext_require=0
let &t_SI = "\033[5 q"
let &t_EI = "\033[1 q"

" ctrlp
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif
let g:ctrlp_working_path_mode='w'

" nerdtree
let g:NERDTreeNodeDelimiter = "\u00a0"
let NERDTreeShowHidden=1

" lightline
let g:lightline = {
  \   'colorscheme': 'nord',
  \   'active': {
  \     'left':[ [ 'mode', 'paste' ],
  \              [ 'gitbranch', 'relativepath', 'noticeMeSenpai' ]
  \     ]
  \   },
  \   'inactive': {
  \     'left':[ [ 'mode', 'paste' ],
  \              [ 'noticeMeSenpai' ]
  \     ]
  \   },
	\   'component': {
	\     'lineinfo': ' %3l:%-2v',
	\   },
  \   'component_function': {
  \     'gitbranch': 'fugitive#head',
  \     'noticeMeSenpai': 'LightlineModified',
  \   }
  \ }
let g:lightline.separator = {
	\   'left': '>>>', 'right': '<<<'
  \}
let g:lightline.subseparator = {
	\   'left': '>>>', 'right': '<<<'
  \}

let g:lightline.tabline = {
  \   'left': [ ['tabs'] ],
  \   'right': [ ['close'] ]
  \ }
function! LightlineModified ()
  let modified = &modified ? '!!!!!!!!!!!!!!!!!' : ''
  return modified
endfunction

" prettier
let g:prettier#autoformat = 0
let g:prettier#config#semi = 'true'
let g:prettier#config#bracket_spacing = 'true'
let g:prettier#config#arrow_parens = 'always'
let g:prettier#config#jsx_bracket_same_line = 'false'
let g:prettier#config#print_width = 100

" nord
let g:nord_cursor_line_number_background = 1
hi clear CursorLine
set cursorline
augroup CLClear
  autocmd! ColorScheme * hi clear CursorLine
augroup END

" Leaders
let mapleader=","
nmap <Leader>n :NERDTreeToggle<CR>
nmap <Leader>p :CtrlP<CR>
nmap <Leader>l :ALELint<CR>
nmap <Leader>d <Plug>(coc-definition)
autocmd filetype go nmap <Leader>d :GoDef<CR>
autocmd filetype go nmap <Leader>r :GoFmt<CR>
autocmd filetype go nmap <Leader>t :GoTest<CR>
nmap <Leader>m :s#_\(\l\)#\u\1#g<CR>

autocmd filetype javascript nmap <Leader>r :Prettier<CR>
autocmd filetype typescript nmap <Leader>r :Prettier<CR>
autocmd filetype svelte nmap <Leader>r :Prettier<CR>
autocmd filetype python nmap <Leader>r :Black<CR>
autocmd filetype python nmap <leader>db oimport ipdb; ipdb.set_trace()<Esc>
autocmd Filetype * AnyFoldActivate

" ALE
let g:ale_lint_on_save = 0
let g:ale_lint_on_text_change = 'never'
let g:ale_lint_on_enter = 0
let g:ale_set_highlights = 1
let g:ale_linters_ignore = {'typescript': ['tslint', 'tsserver']}
let g:ale_linter_aliases = {'svelte': ['css', 'javascript']}
let g:ale_linters = {
  \ 'javascript': ['eslint'],
  \ 'typescript': ['eslint'],
  \ 'python': ['flake8'],
  \ 'svelte': ['eslint'],
  \}
let g:ale_fixers = {
  \'python': ['black']
  \}
let g:black_skip_string_normalization = 1

let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let vim_markdown_preview_github=1

autocmd filetype crontab setlocal nobackup nowritebackup
nmap <Tab> :b#<CR>
