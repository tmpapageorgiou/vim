set nocompatible              " required
filetype off                  " required

"=====================
" Plugins Setup
"=====================

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Python plugins
Plugin 'vim-scripts/indentpython.vim'
"Plugin 'davidhalter/jedi-vim'
"Plugin 'scrooloose/syntastic'
"Plugin 'nvie/vim-flake8'

" Javascript plugins
Plugin 'elzr/vim-json'
Plugin 'pangloss/vim-javascript' " js support improvements

" Java plugins
Plugin 'artur-shaik/vim-javacomplete2'

" Go pluging
Plugin 'fatih/vim-go'

" C plugins
" Plugin 'Valloric/YouCompleteMe'

" General editor plugins
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-commentary'
"Plugin 'vim-airline/vim-airline'
Plugin 'ervandew/supertab'
Plugin 'moll/vim-bbye'
Plugin 'terryma/vim-multiple-cursors'
"Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}

" Git
Plugin 'tpope/vim-fugitive'

" Color schemes
Plugin 'geoffharcourt/one-dark.vim'
Plugin 'morhetz/gruvbox'
Plugin 'sickill/vim-monokai'
Plugin 'fatih/molokai'

" All of your Plugins must be added before the following line
call vundle#end()            " required


syntax on
filetype on
filetype plugin on
filetype plugin indent on

" Rebind <Leader> key
let mapleader = ","

"=====================
" Plugins Settings
"=====================

"=========
" NERDTree

map <Leader>t :NERDTreeToggle<CR>
" Open NERDTree when startup
"autocmd vimenter * NERDTree
" Open a NERDTree automatically when vim starts up if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Never let NERDTree alone
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"=============
" CtrlP
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](node_modules|cache|busca|__pycache__|.git)$',
  \ 'file': '\v\.(DS_Store|svn|png|jpe?g|gif|elc|rbc|pyc|swp|psd|ai|pdf|log|mov|aep|dmg|zip|gz)$',
  \ }


"=============
" Supertab
let g:SuperTabDefaultCompletionType = "context"


"=============
" JEDI-VIM

let g:jedi#popup_on_dot = 0
let g:jedi#popup_select_first = 0
let g:jedi#auto_initialization = 1
let g:jedi#force_py_version = 3

let g:pymode_rope = 0
let g:pymode_virtualenv=1
let python_highlight_all=1
syntax on

"python with virtualenv support
if has( 'python')
py << EOF
import os
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  sys.path.insert(0, project_base_dir)
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF
endif

"=============
" syntax checker

" autocmd BufRead *.py let g:syntastic_always_populate_loc_list = 1
" autocmd BufRead *.py let g:syntastic_auto_loc_list = 1
" autocmd BufRead *.py let g:syntastic_check_on_open = 0
" autocmd BufRead *.py let g:syntastic_check_on_wq = 0
let g:syntastic_error_symbol='ø'
let g:syntastic_warning_symbol='!'
let g:syntastic_style_error_symbol = 'ø'
let g:syntastic_style_warning_symbol = '!'
"let g:syntastic_aggregate_errors = 1
let g:syntastic_enable_signs = 0
let g:syntastic_enable_balloons = 0
let g:syntastic_enable_highlighting = 0
let g:syntastic_python_checkers=['flake8'] ", 'pyflakes']


"============
" Vim Multiple cursors
"
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'
let g:multi_cursor_start_key='<C-n>'
let g:multi_cursor_start_word_key='w<C-n>'

"============
" Vim Go
let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1

autocmd FileType go nmap <Leader>d  <Plug>(go-def)
autocmd FileType go nmap <Leader>D  <Plug>(go-def-pop)
autocmd FileType go nmap <Leader>o  <Plug>(go-doc)
autocmd FileType go nmap <Leader>i  <Plug>(go-imports)

"============
" Vim Monokai
syntax enable
colorscheme monokai

"============
" Vim Molokai
""let g:rehash256 = 1
""let g:molokai_original = 1
""colorscheme molokai

"============
" Key Mapping
"============

" Navigation between windows
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" map sort function to a key
vnoremap <Leader>s :sort<CR>

" nnoremap <leader>n :bprev<CR>
nnoremap <leader>m :bnext<CR>
nnoremap <leader>n :bprev<CR>

" indentation command
vnoremap < <gv " better indentation
vnoremap > >gv " better indentation

" auto complete markers on insert mode
imap { {}<left>
imap ( ()<left>
imap [ []<left>
imap " <C-V>"<C-V>"<left>
imap ' <C-V>'<C-V>'<left>

"==================
" Language Specific
"==================

set ts=4 sts=4 sw=4 autoindent shiftround
autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype c setlocal ts=4 sts=4 sw=4 cindent noexpandtab
autocmd Filetype go setlocal ts=4 sts=4 sw=4 cindent noexpandtab
autocmd Filetype python setlocal ts=4 sts=4 sw=4 expandtab autoindent shiftround
autocmd Filetype java setlocal ts=4 sts=4 sw=4 expandtab autoindent shiftround
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2

autocmd FileType python setlocal commentstring=#\ %s

autocmd FileType python map <Leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>
autocmd FileType go map <Leader>b Ofmt.Println("\n") // DEBUGING<C-c>
autocmd FileType c map <Leader>b Oprintf("\n"); // DEBUGING<C-c>

"=============
" COMMON SETUP
"=============

" Color scheme
" colorscheme onedark
" set background=dark	" improve syntax highlighting for dark backgrounds
" set t_Co=256
" color wombat256mod

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace / \+$/

highlight SignColumn ctermbg=230
set colorcolumn=+1

set nofoldenable

" AUto remove trailing white spaces before save
" autocmd BufReadPre,BufWritePre * :%s/\s\+$//e

" enter command mode with ;
nnoremap ; :

" File extension modifiers
set nospell
set modifiable
"autocmd BufRead *.tex set spell spelllang=pt_br

set encoding=utf-8

" make backspaces more powerfull
set backspace=indent,eol,start

if has("syntax")
  syntax on
endif

" easier formatting of paragraphs
vmap Q gq
nmap Q gqap

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd		" Show (partial) command in status line.
set number      	" show line number
set hidden 		" allows buffers to be hide even if it is modified
set title 		" show file nam in the tittle bar
set laststatus=2        " the statusline is now always shown
set showmode            " show mode in status bar (insert/replace/...)
set statusline=%<%f\ (%{&ft})\ -\ %{fugitive#statusline()}%-4(%m%)%=%-19(%3l,%02c%03V%)
set fileformat=unix
set fileformats=unix,dos,mac   " detects unix, dos, mac file formats in that order
set clipboard=unnamed   " copping to clipboard

" Searching settings
set hlsearch		" Highlighting for searches
set incsearch		" Incremental search
set ignorecase		" Do case insensitive matching
set showmatch		" Show matching brackets.
set smartcase		" Do smart case matching

" Paste toggle button
set pastetoggle=<F2> 	" Set F2 as past mode toggle
set copyindent          " copy the previous indentation on autoindenting

" Jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif
