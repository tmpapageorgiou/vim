set nocompatible              " required
filetype off                  " required

"=====================
" Plugins Setup
"=====================

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged')

" Python plugins
Plug 'vim-scripts/indentpython.vim', { 'for': 'python' }
Plug 'davidhalter/jedi-vim', { 'for': 'python' }
"Plugin 'scrooloose/syntastic'
"Plugin 'nvie/vim-flake8'

" Javascript plugins
Plug 'elzr/vim-json'
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }

" Java plugins
Plug 'artur-shaik/vim-javacomplete2', { 'for': 'java' }

" Go pluging
Plug 'fatih/vim-go', { 'for': 'go', 'do': ':GoInstallBinaries' }

" C plugins
" Plug 'Valloric/YouCompleteMe', { 'for': 'c', 'do': './install.py --clang-completer' }
" Need to install cscope `sudo apt-get install cscope`
Plug 'brookhong/cscope.vim', { 'for': 'c', 'do': 'gksudo apt-get install cscope' }
Plug 'szw/vim-tags', { 'for': 'c' }

" Snipets
" Plug 'Shougo/neocomplcache'
" Track the engine.
Plug 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'


" General editor plugins
Plug 'scrooloose/nerdtree'
Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-commentary'
Plug 'ervandew/supertab'
Plug 'moll/vim-bbye'
Plug 'terryma/vim-multiple-cursors'
" Plug 'Townk/vim-autoclose'
Plug 'Raimondi/delimitMate'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-sleuth'

" Git
Plug 'tpope/vim-fugitive'

" Color schemes
Plug 'geoffharcourt/one-dark.vim'
Plug 'morhetz/gruvbox'
Plug 'sickill/vim-monokai'

call plug#end()

syntax on
filetype on
filetype plugin on
filetype plugin indent on

" Rebind <Leader> key
let mapleader = ","

"=====================
" Plugins Settings
"=====================

"========
" Vim Ack
cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space><C-W><CR>

"======
" CtrlP
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](node_modules|cache|busca|__pycache__|.git)$',
  \ 'file': '\v\.(DS_Store|svn|png|jpe?g|gif|elc|rbc|pyc|swp|psd|ai|pdf|log|mov|aep|dmg|zip|gz)$',
  \ }
nnoremap <C-b> :CtrlPBuffer<CR>

"===========
" Cscope
autocmd FileType c nnoremap <leader>fa :call CscopeFindInteractive(expand('<cword>'))<CR>
autocmd FileType c nnoremap <leader>l :call ToggleLocationList()<CR>
" s: Find this C symbol
autocmd FileType c nnoremap <leader>fs :call CscopeFind('s', expand('<cword>'))<CR>
" g: Find this definition
" autocmd FileType c nnoremap <leader>d :call CscopeFind('g', expand('<cword>'))<CR>
" d: Find functions called by this function
autocmd FileType c nnoremap <leader>fd :call CscopeFind('d', expand('<cword>'))<CR>
autocmd FileType c nnoremap <leader>R :call CscopeFind('c', expand('<cword>'))<CR>
" i: Find files #including this file
autocmd FileType c nnoremap <leader>fi :call CscopeFind('i', expand('<cword>'))<CR>

"======
" Ctags
autocmd FileType c nnoremap <leader>d <C-]>
autocmd FileType c nnoremap <leader>D <C-t>

"=======
" Vim Go
let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
" let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
"let g:go_auto_sameids = 1
"let g:go_updatetime = 800
let g:go_list_type = "quickfix"

autocmd FileType go nmap <Leader>d <Plug>(go-def)
autocmd FileType go nmap <Leader>D <Plug>(go-def-pop)
autocmd FileType go nnoremap <Leader>R :GoReferrers<CR>
autocmd FileType go nmap <Leader>o <Plug>(go-doc)
autocmd FileType go nmap <Leader>i <Plug>(go-imports)
autocmd FileType go nmap <Leader>r <Plug>(go-rename)
autocmd FileType go nnoremap <Leader>l :GoDecls<CR>

"=========
" Jedi-vim

let g:jedi#popup_on_dot = 0
let g:jedi#popup_select_first = 0
let g:jedi#auto_initialization = 1
let g:jedi#force_py_version = 3

let g:pymode_rope = 0
let g:pymode_virtualenv=1
let python_highlight_all=1

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

"===========
" ultisnip

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-m>"
let g:UltiSnipsJumpBackwardTrigger="<c-?>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
" List snippets
let g:UltiSnipsListSnippets="<c-l>"

"let g:UltiSnipsSnippetDir='~/.vim/my-snippets'
let g:UltiSnipsSnippetDirectories=['my-snippets']

""===========
"" Newsnippet
"
"" key-mappings.
"" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
"imap <C-k>     <Plug>:neosnippet_expand_or_jump
"smap <C-k>     <Plug>:neosnippet_expand_or_jump
"xmap <C-k>     <Plug>:neosnippet_expand_target
"
"" SuperTab like snippets behavior.
"" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
""imap <expr><TAB>
"" \ pumvisible() ? "\<C-n>" :
"" \ neosnippet#expandable_or_jumpable() ?
"" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
"smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
"\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
"
"" For conceal markers.
"if has('conceal')
"  set conceallevel=2 concealcursor=niv
"endif

"============
" Vim Molokai
"let g:rehash256 = 1
"let g:molokai_original = 1
"colorscheme molokai

"============
" Vim Monokai
" syntax enable
" colorscheme monokai

"=====================
" Vim Multiple cursors
"
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'
let g:multi_cursor_start_key='<C-n>'
let g:multi_cursor_start_word_key='w<C-n>'

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

"=========
" Supertab
let g:SuperTabDefaultCompletionType = "context"

"===============
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

"====================
" YCM - YouCompleteMe
let g:ycm_confirm_extra_conf = 0

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

"Pressing backspace in normal mode behaves like it would in insert mode
nnoremap <silent> <Backspace> i<Backspace><ESC>l

" Remove search results highlights
nnoremap <Leader><space> :nohlsearch<CR>

" Formatting of paragraphs
vmap Q gq
nmap Q gqap

" enter command mode with ;
nnoremap ; :

" Save CTRL+a in all modes
noremap  <C-a> :update<CR>
vnoremap <C-a> <C-C>:update<CR>
inoremap <C-a> <C-O>:update<CR>

" Save and quit CTRL+x in all modes
noremap  <C-x> :x<CR>
vnoremap <C-x> <C-C>:x<CR>
inoremap <C-x> <C-O>:x<CR>

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
colorscheme monokai
"colorscheme onedark
set background=dark	" improve syntax highlighting for dark backgrounds
set t_Co=256
color wombat256mod

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace / \+$/

highlight SignColumn ctermbg=230
set colorcolumn=+1


" File extension modifiers
set nospell
set modifiable
"autocmd BufRead *.tex set spell spelllang=pt_br

set encoding=utf-8

" make backspaces more powerfull
set backspace=indent,eol,start


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
set scrolloff=10  "Keep at least 10 lines in view when the cursor hits the bottom of the buffer"
set nofoldenable
set notimeout	"Wait indefinitely for a keypress when we press the leader key"
set cursorline	"Show the current line you're on"
set wildmenu	"Show completions in a bar"
set ruler	"Show our current position"

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
