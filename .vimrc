" Plugins
call plug#begin('~/.vim/plugged')
  " NTH plugins
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'tpope/vim-fugitive'
  Plug 'scrooloose/nerdtree'
  Plug 'tpope/vim-abolish'
  Plug 'mhartington/oceanic-next'
  Plug 'w0rp/ale'
  Plug 'scrooloose/nerdcommenter'
  Plug 'ntpeters/vim-better-whitespace'
  Plug 'itchyny/lightline.vim'

  " Language plugins
  Plug 'ElmCast/elm-vim'
  Plug 'prettier/vim-prettier'
  Plug 'vim-ruby/vim-ruby'
  Plug 'pangloss/vim-javascript'
  Plug 'mxw/vim-jsx'
  Plug 'flowtype/vim-flow', {
    \ 'autoload': {
    \   'filetypes': 'javascript'
    \ },
    \ 'build': {
    \   'mac': 'npm install -g flow-bin'
    \ }}
call plug#end()

let local_flow = finddir('node_modules', '.;') . '/.bin/flow'
if matchstr(local_flow, "^\/\\w") == ''
  let local_flow= getcwd() . "/" . local_flow
endif
if executable(local_flow)
  let g:flow#flowpath = local_flow
endif

" Functions
function SwitchBuffer()
  b#
endfunction

if (has("termguicolors"))
  set termguicolors
endif
colorscheme OceanicNext

syntax enable
set nocompatible
set number
set hlsearch
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set smarttab
set noswapfile
set laststatus=2
set background=dark
set lazyredraw
set backspace=2
set autoread
autocmd filetype crontab setlocal nobackup nowritebackup
filetype plugin indent on

" other plugin settings
let g:netrw_liststyle=3
let g:jsx_ext_require=0
let NERDTreeShowHidden=1
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
let g:elm_format_autosave = 1
let g:airline_theme='oceanicnext'
let g:NERDTreeNodeDelimiter = "\u00a0"

let g:lightline = {
  \   'colorscheme': 'oceanicnext',
  \   'active': {
  \     'left':[ [ 'mode', 'paste' ],
  \              [ 'gitbranch', 'readonly', 'filename', 'modified' ]
  \     ]
  \   },
	\   'component': {
	\     'lineinfo': ' %3l:%-2v',
	\   },
  \   'component_function': {
  \     'gitbranch': 'fugitive#head',
  \   }
  \ }
let g:lightline.separator = {
	\   'left': '>>>', 'right': '<<<'
  \}
let g:lightline.subseparator = {
	\   'left': '>', 'right': '>'
  \}

let g:lightline.tabline = {
  \   'left': [ ['tabs'] ],
  \   'right': [ ['close'] ]
  \ }
set showtabline=2  " Show tabline
set guioptions-=e  " Don't use GUI tabline

" prettier
let g:prettier#autoformat = 0
let g:prettier#config#semi = 'false'
let g:prettier#config#bracket_spacing = 'true'
let g:prettier#config#arrow_parens = 'always'
let g:prettier#config#jsx_bracket_same_line = 'false'
let g:prettier#config#print_width = 100

" Leaders
let mapleader=","
nmap <Leader>n :NERDTreeToggle<CR>
nmap <Leader>p :CtrlP<CR>
nmap <Leader>l :ALELint<CR>
nmap <Leader>lf :ALEFix<CR>
nmap <Leader>r :Prettier<CR>
nmap <Leader>d :FlowJumpToDef<CR>

let g:ale_lint_on_save = 0
let g:ale_lint_on_text_change = 'never'
let g:ale_lint_on_enter = 0
let g:ale_set_highlights = 0
let g:ale_linters_ignore = ['tsserver']
let g:ale_linters = {
  \ 'javascript': ['eslint', 'flow']
  \ }

nmap <Tab> :call SwitchBuffer()<CR>
