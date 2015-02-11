"call pathogen#infect()
    " All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
    " /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime
    " you can find below.  If you wish to change any of those settings, you should
    " do it in this file (/etc/vim/vimrc), since debian.vim will be overwritten
    " everytime an upgrade of the vim packages is performed.  It is recommended to
    " make changes after sourcing debian.vim since it alters the value of the
    " 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim


" =============
" MY LABORATORY
" =============

" Auto reload vim.rc
" autocmd! bufwritepost .vimrc source %

" Rebind <Leader> key
let mapleader = ","

" Navigation between windows
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" easier moving between tabs
map <Leader>n <esc>:tabprevious<CR>
map <Leader>m <esc>:tabnext<CR>

" map sort function to a key
vnoremap <Leader>s :sort<CR>

vnoremap < <gv " better indentation
vnoremap > >gv " better indentation

" Show whitespace
" MUST be inserted BEFORE the colorscheme command
" autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
" au InsertLeave * match ExtraWhitespace /\s\+$/

" Color scheme
" mkdir -p ~/.vim/colors && cd ~/.vim/colors
" wget -O wombat256mod.vim http://www.vim.org/scripts/download_script.php?src_id=13400
set t_Co=256
color wombat256mod

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace / \+$/ 

highlight SignColumn ctermbg=230
set colorcolumn=80

" easier formatting of paragraphs
vmap Q gq
nmap Q gqap

" Setup Pathogen to manage your plugins
" mkdir -p ~/.vim/autoload ~/.vim/bundle
" curl -so ~/.vim/autoload/pathogen.vim https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim
" Now you can install any plugin into a .vim/bundle/plugin-name/ folder
call pathogen#infect()

" Settings for jedi-vim
" cd ~/.vim/bundle
" git clone git://github.com/davidhalter/jedi-vim.git
"" let g:jedi#usages_command = "<Leader>z"
let g:jedi#popup_on_dot = 0
let g:jedi#popup_select_first = 0
let g:jedi#auto_initialization = 1
let g:jedi#rename_command = "<leader>R"
map <Leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>

" Supertab
let g:SuperTabDefaultCompletionType = "context"

" Python folding
" mkdir -p ~/.vim/ftplugin
" wget -O ~/.vim/ftplugin/python_editing.vim http://www.vim.org/scripts/download_script.php?src_id=5492
set nofoldenable

" AUto remove trailing spaces before save
autocmd BufWritePre *.py :%s/\s\+$//e

" ===============
"  END LABORATORY
" ===============


" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the
" following enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"if has("autocmd")
"  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
  filetype plugin indent on
endif

"autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guigb=red
"au InsertLeave * match ExtraWhitespace /\s\+$/ 
"highlight OverLength ctermbg=red ctermfg=white guibg=#592929 
"match OverLength /\%81v.*/

"highlight ExtraWhitespace ctermbg=red ctermfg=white guibg=#592929 
"match ExtraWhitespace /\s\+$/

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd		" Show (partial) command in status line.
set number      "show line number
"set autowrite		" Automatically save before commands like :next and :make
"set hidden             " Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes)
" set tw=79       " width of document
set background=dark	" improve syntax highlighting for dark backgrounds


" Searching settings
set hlsearch		" Highlighting for searches
set incsearch		" Incremental search
set ignorecase		" Do case insensitive matching
set showmatch		" Show matching brackets.
"set smartcase		" Do smart case matching


" Identation
set ts=4       		" set tabstop at 4
set expandtab		" expand each tab in spaces
set shiftwidth=4        " size of automatic indentation
set shiftround
set softtabstop=4       " must be same of ts to make sense
set ai			" set autoident

set viminfo='10,\"100,:20,%,n~/.viminfo " memoriza posicao do arquivo desde a ultima edicao
set pastetoggle=<F2>

set ai			" set autoident
"source ~/.vim/plugin/cscope_maps.vim

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

filetype plugin indent on
