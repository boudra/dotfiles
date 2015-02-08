set nocompatible
filetype off
set encoding=utf-8

if has('win32') || has('win64')
    set runtimepath=$HOME/.vim,$HOME/vimfiles
endif

set rtp+=~/.vim/bundle/vundle/

call vundle#rc()

Bundle 'gmarik/vundle'

Bundle 'Shougo/vimproc.vim'
Bundle 'syntastic'
Bundle 'scrooloose/nerdtree'
Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
Bundle 'garbas/vim-snipmate'
Bundle 'honza/vim-snippets'
Bundle 'rhysd/vim-clang-format'
Bundle 'altercation/vim-colors-solarized'
Bundle 'a.vim'
Bundle 'octol/vim-cpp-enhanced-highlight'
Bundle 'xolox/vim-misc'
Bundle 'xolox/vim-easytags'
Bundle 'nanotech/jellybeans.vim'
Bundle 'tomasr/molokai'
Bundle 'w0ng/vim-hybrid'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'argtextobj.vim'
Bundle 'Raimondi/delimitMate'
Bundle 'tpope/vim-dispatch'
Bundle 'tpope/vim-surround'
Bundle 'xolox/vim-session'
Bundle 'nathanaelkane/vim-indent-guides'

" Javascript
Bundle 'pangloss/vim-javascript'
Bundle 'othree/javascript-libraries-syntax.vim'
Bundle 'jelera/vim-javascript-syntax'
Bundle 'JavaScript-Indent'

" HTML
Bundle 'mattn/emmet-vim'
"Bundle 'othree/html5.vim'
Bundle 'chrisbra/Colorizer'
Bundle 'valloric/MatchTagAlways'
Bundle 'digitaltoad/vim-jade'
"Bundle 'brookhong/DBGPavim'

Bundle 'croaky/vim-colors-github'
Bundle 'chriskempson/vim-tomorrow-theme'

" GLSL
Bundle 'tikhomirov/vim-glsl'

let mapleader=","

" Bind C-h to Emmet expander
imap <C-h> <C-y>,
vmap <C-h> <C-y>,
nmap <C-h> <C-y>,

syntax on 
set cino=N-s

" display indentation guides
set list listchars=tab:--,trail:.,extends:»,precedes:«,nbsp:×

" convert spaces to tabs when reading file
" autocmd! bufreadpost * if &l:modifiable | set noexpandtab | retab! 4 | endif

" convert tabs to spaces before writing file
" autocmd! bufwritepre * set expandtab | retab! 4

" convert spaces to tabs after writing file (to show guides again)
" autocmd! bufwritepost * set noexpandtab | retab! 4

filetype plugin indent on

if has("gui_running")
    " Disable menu, scrollbar
    set guiheadroom=0
    set guioptions-=m
    set guioptions-=T
    set guioptions-=r
    set guioptions-=L
    set guioptions-=e
    if has("gui_gtk2")
        set guifont=Inconsolata\ for\ Powerline\ Medium\ 13
    elseif has("gui_macvim")
        set guifont=Menlo\ Regular:h14
    elseif has("gui_win32")
        set guifont=Consolas:h11:cANSI
    endif
endif

nnoremap <F5> :make<CR>

" Switch from header to source and viceversa
nnoremap <F4> :A<CR>

nnoremap <F12> :colorscheme Tomorrow<enter>:TOhtml<enter>:colorscheme Tomorrow-Night<enter>:w<enter>:!firefox file://%:p<enter>:!rm %:p<enter>:q<enter><enter>

autocmd filetype cpp setl makeprg=make\ -C\ ../build

set path=.,,**
set suffixesadd=".cpp .hpp .java .php .html"


let g:mta_filetypes = {
    \ 'html' : 1,
    \ 'xhtml' : 1,
    \ 'xml' : 1,
    \ 'jinja' : 1,
	\ 'php' : 1,
    \ }

let g:clang_format#auto_format = 0
let g:clang_format#code_style = 'google' 
let g:clang_format#style_options = {
    \ "AlwaysBreakTemplateDeclarations" : "true",
    \ "BreakBeforeBraces" : "Allman",
    \ "KeepEmptyLinesAtTheStartOfBlocks" : "true",
    \ "PointerAlignment" : "Left",
    \ "Standard" : "Cpp11",
    \ "TabWidth" : "4",
    \ "UseTab" : "Never",
    \ "ColumnLimit" : "80",
    \ "AccessModifierOffset" : "-4",
    \ "AllowShortFunctionsOnASingleLine" : "None",
    \ "AllowShortIfStatementsOnASingleLine" : "true",
    \ }

autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :silent <C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :slilent ClangFormat<CR>

let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_auto_refresh_includes = 1
let g:syntastic_cpp_compiler_options = '-std=c++11'
let g:syntastic_auto_loc_list = 1
let g:syntastic_cpp_compiler = 'clang++'

let g:easytags_events = ['BufWritePost']
let g:easytags_async = 1
let g:easytags_dynamic_files = 2
set tags=./.tags;,~/.vimtags

set t_Co=256
colorscheme Tomorrow-Night-Bright

highlight MatchParen gui=bold,underline,italic term=underline guibg=NONE guifg=white ctermbg=none ctermfg=none 

" Enable line highlighting on insert
autocmd InsertEnter,InsertLeave * set cul!

" Copy and paste operations
inoremap <C-v> <C-o>"+p
nnoremap <C-v> "+p
vmap <C-c> "+y
vmap <C-x> "+c
vmap <C-v> c<C-o>"+p

map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
nmap s <Plug>(easymotion-s2)

nmap <Leader>w :w<CR>
nmap <Leader>e :e **
nmap <Leader>q :q<CR>
nmap <Leader>f <C-w><C-f>

nnoremap <C-p> :tabprevious<CR>
nnoremap <C-n> :tabnext<CR>
nnoremap <C-tab> :tabnext<CR>
nnoremap <C-t> :tabnew<CR>
nnoremap <C-Delete> :tabclose<CR>

let g:colorizer_auto_filetype='css,html'
let g:html_use_css = 0
let g:EasyMotion_use_smartsign_us = 1
let g:EasyMotion_smartcase = 1

let g:session_autosave = 'yes'

map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)

" Disable the arrow keys
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>

let g:dbgPavimPort = 9009
let g:dbgPavimBreakAtEntry = 0

nmap <Tab> :NERDTreeToggle<CR>

set foldmethod=syntax
set textwidth=80
set foldlevel=1
set foldlevelstart=20

set laststatus=2
set wrap
set number
set relativenumber
set nobackup
set noswapfile
set vb t_vb=


" use 4 spaces for tabs
set smartindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

if(exists('breakindent'))
	set breakindent
endif

let g:indent_guides_guide_size = 1
set regexpengine=1

let g:used_javascript_libs = 'jquery,angularjs,angularui'
