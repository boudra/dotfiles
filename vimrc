set nocompatible
filetype off
set encoding=utf-8

set rtp+=~/.vim/bundle/vundle/

call vundle#rc()

Bundle 'gmarik/vundle'

Bundle 'Shougo/vimproc.vim'
Bundle 'syntastic'
Bundle 'nerdtree'
Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle "tomtom/tlib_vim"
Bundle "garbas/vim-snipmate"
Bundle "honza/vim-snippets"
Bundle "rhysd/vim-clang-format"
Bundle "altercation/vim-colors-solarized"
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
" Javascript
Bundle "pangloss/vim-javascript"

" HTML
Bundle "mattn/emmet-vim"
"Bundle "othree/html5.vim"

let mapleader=","

imap <C-h> <C-y>,
vmap <C-h> <C-y>,
nmap <C-h> <C-y>,

" GLSL
Bundle 'tikhomirov/vim-glsl'

syntax on 

set cino=N-s

let g:Powerline_symbols = '' 

" use 4 spaces for tabs
set tabstop=4 softtabstop=4 shiftwidth=4

" display indentation guides
set list listchars=tab:>-,trail:.,extends:»,precedes:«,nbsp:×

" convert spaces to tabs when reading file
autocmd! bufreadpost * set noexpandtab | retab! 4

" convert tabs to spaces before writing file
autocmd! bufwritepre * set expandtab | retab! 4

" convert spaces to tabs after writing file (to show guides again)
autocmd! bufwritepost * set noexpandtab | retab! 4


filetype plugin indent on

if has("gui_running")
    set guiheadroom=0
    set guioptions-=m
    set guioptions-=T
    set guioptions-=r
    set guioptions-=L
    if has("gui_gtk2")
        set guifont=Anonymous\ Pro\ for\ Powerline\ 12
    elseif has("gui_macvim")
        set guifont=Menlo\ Regular:h14
    elseif has("gui_win32")
        set guifont=Consolas:h11:cANSI
    endif
endif

nnoremap <F5> :Make<CR><C-l>
nnoremap <F4> :A<CR>

autocmd filetype cpp setl makeprg=make\ -C\ ../build

set path=**
set suffixesadd=".cpp .hpp .java .php .html"

let g:clang_format#auto_format = 0
let g:clang_format#code_style = 'google' 

let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_auto_refresh_includes = 1
let g:syntastic_cpp_compiler_options = '-std=c++11'
let g:syntastic_auto_loc_list = 1
"let g:syntastic_cpp_compiler = 'clang++'

let g:easytags_events = ['BufWritePost']
let g:easytags_async = 1
let g:easytags_dynamic_files = 2
set tags=./.tags;,~/.vimtags

set t_Co=256
set background=dark
colorscheme hybrid 

highlight Normal ctermbg=black guibg=#111111
highlight nonText ctermbg=black guibg=#111111
highlight MatchParen gui=bold,underline,italic term=underline guibg=NONE guifg=white ctermbg=none ctermfg=none 

autocmd InsertEnter,InsertLeave * set cul!

inoremap <C-v> <C-o>"+p
nnoremap <C-v> "+p
vmap <C-c> "+y
vmap <C-x> "+c
vmap <C-v> c<C-o>"+p

map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
nmap s <Plug>(easymotion-s2)

nmap <Leader>w :w<CR>
nmap <Leader>e :e 
nmap <Leader>q :q<CR>

let g:EasyMotion_use_smartsign_us = 1
let g:EasyMotion_smartcase = 1

map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)

inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>

nmap <Tab> :NERDTreeToggle<CR>

set laststatus=2
set nowrap
set number
set relativenumber
set nobackup
set noswapfile
set vb t_vb=
