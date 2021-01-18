" Plugins
call plug#begin('~/.vim/plugged')
  " NTH plugins
  Plug 'christoomey/vim-system-copy'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'itchyny/lightline.vim'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'ntpeters/vim-better-whitespace'
  Plug 'ryanoasis/vim-devicons'
  Plug 'scrooloose/nerdcommenter'
  Plug 'scrooloose/nerdtree'
  Plug 'tpope/vim-fugitive'
  Plug 'w0rp/ale'
  Plug 'pluralsight/activity-insights-vim'
  Plug 'joshdick/onedark.vim'

  " Language plugins
  Plug 'Quramy/tsuquyomi'
  Plug 'maxmellon/vim-jsx-pretty'
  Plug 'peitalin/vim-jsx-typescript'
  Plug 'elzr/vim-json'
  Plug 'fatih/vim-go'
  Plug 'leafgarland/typescript-vim'
  Plug 'pangloss/vim-javascript'
  Plug 'rust-lang/rust.vim'
call plug#end()

if &term =~ '256color'
    " disable Background Color Erase (BCE) so that color schemes
    " render properly when inside 256-color tmux and GNU screen.
    " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
    set t_ut=
endif
colorscheme onedark

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
let g:coc_global_extensions = ['coc-solargraph']

let g:netrw_liststyle=3
let g:jsx_ext_require=0
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

" lightline
let g:lightline = {
  \   'colorscheme': 'iceberg',
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

" Leaders
let mapleader=","
nmap <Leader>n :NERDTreeToggle<CR>
nmap <Leader>p :CtrlP<CR>
nmap <Leader>l :ALELint<CR>
nmap <Leader>d :call CocAction('jumpDefinition', 'drop')<CR>
nmap <Leader>h :ALEHover<CR>
nmap <Leader>r :ALEFix<CR>
nmap <Leader>m :s#_\(\l\)#\u\1#g<CR>
autocmd filetype go nmap <Leader>d :GoDef<CR>
autocmd filetype go nmap <Leader>r :GoFmt<CR>
autocmd filetype go nmap <Leader>t :GoTest<CR>

" ALE
let g:ale_linters_specific = 1

let g:ale_lint_on_save = 0
let g:ale_lint_on_text_change = 'never'
let g:ale_lint_on_enter = 0
let g:ale_set_highlights = 1

let g:ale_linters_ignore = {'typescript': ['tslint']}
let g:ale_linter_aliases = {'typescriptreact': ['typescript'], 'javascriptreact': ['javascript']}
let g:ale_fixer_aliases = {'typescriptreact': ['typescript'], 'javascriptreact': ['javascript']}

let g:ale_linters = {
  \ 'javascript': ['eslint'],
  \ 'javascriptreact': ['eslint'],
  \ 'rust': ['cargo'],
  \ 'ruby': ['standardrb'],
  \ 'typescript': ['eslint', 'tsserver'],
  \ 'typescriptreact': ['eslint', 'tsserver'],
  \}
let g:ale_fixers = {
  \ 'javascript': ['prettier'],
  \ 'javascriptreact': ['prettier'],
  \ 'ruby': ['standardrb'],
  \ 'rust': ['rustfmt'],
  \ 'typescript': ['prettier'],
  \ 'typescriptreact': ['prettier'],
  \}

function! LinterStatus()
  let l:counts = ale#statusline#Count(bufnr(''))

  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors

  return l:counts.total == 0 ? '✨ all good ✨' : printf(
        \   '😞 %dW %dE',
        \   all_non_errors,
        \   all_errors
        \)
endfunction

set statusline=
set statusline+=%m
set statusline+=\ %f
set statusline+=%=
set statusline+=\ %{LinterStatus()}

let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

autocmd filetype crontab setlocal nobackup nowritebackup
nmap <Tab> :b#<CR>
