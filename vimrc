if 0 | endif

set nocompatible
filetype off
set encoding=utf-8

if has('win32') || has('win64')
    set runtimepath=$HOME/.vim,$HOME/vimfiles
endif

set runtimepath+=~/.vim/bundle/neobundle.vim/

call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc.vim'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'bling/vim-airline'
NeoBundle 'MarcWeber/vim-addon-mw-utils'
NeoBundle 'tomtom/tlib_vim'
NeoBundle 'SirVer/ultisnips'
NeoBundle 'honza/vim-snippets'
NeoBundle 'rhysd/vim-clang-format'
NeoBundle 'a.vim'
NeoBundle 'octol/vim-cpp-enhanced-highlight'
NeoBundle 'xolox/vim-misc'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'argtextobj.vim'
NeoBundle 'Raimondi/delimitMate'
NeoBundle 'tpope/vim-dispatch'
NeoBundle 'tpope/vim-surround'
NeoBundle 'xolox/vim-session'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'godlygeek/tabular'
NeoBundle 'netrw.vim'
NeoBundle 'fugitive.vim'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'takahirojin/gbr.vim'
NeoBundle 'kristijanhusak/vim-hybrid-material'
NeoBundle 'ntpeters/vim-better-whitespace'
NeoBundle 'rking/ag.vim'
NeoBundle 'unblevable/quick-scope'
NeoBundle 'AndrewRadev/splitjoin.vim'
NeoBundle 'christoomey/vim-tmux-navigator'
NeoBundle 'joonty/vdebug'
NeoBundle 'xsbeats/vim-blade'
NeoBundle 'fatih/vim-go'
NeoBundle 'matchit.zip'
NeoBundle 'mattn/gist-vim', {'depends': 'mattn/webapi-vim'}
NeoBundle 'mhinz/vim-startify'
NeoBundle 'rust-lang/rust.vim'
NeoBundle 'matze/vim-move'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tommcdo/vim-exchange'

" Javascript
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'leafgarland/typescript-vim'
NeoBundle 'marijnh/tern_for_vim'

" HTML
NeoBundle 'mattn/emmet-vim'
NeoBundle 'othree/html5.vim'
NeoBundle 'chrisbra/Colorizer'
NeoBundle 'valloric/MatchTagAlways'

NeoBundle 'chriskempson/vim-tomorrow-theme'

" GLSL
NeoBundle 'tikhomirov/vim-glsl'

NeoBundle 'sql.vim'
NeoBundle 'mkarmona/colorsbox'

" Elixir
NeoBundle 'elixir-lang/vim-elixir'
NeoBundle 'mattreduce/vim-mix'

call neobundle#end()

NeoBundleCheck

let mapleader=","

let g:user_emmet_install_global = 0
autocmd FileType html,css,blade EmmetInstall
autocmd FileType html,css,blade imap <Tab> <C-y>,
autocmd FileType html,css,blade nmap <Tab> <C-y>,
autocmd FileType html,css,blade vmap <Tab> <C-y>,

syntax on
set cino=N-s

" display indentation guides
set list listchars=tab:▸\ ,trail:.,extends:»,precedes:«,nbsp:×,eol:↲

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
        set guifont=Inconsolata-g\ for\ Powerline\ 11
    elseif has("gui_macvim")
        set guifont=Meslo\ LG\ L\ DZ\ for\ Powerline:h12
    elseif has("gui_win32")
        set guifont=Consolas:h11:cANSI
    endif
endif


set linespace=1

nnoremap <F5> :make<CR>
nnoremap <Leader>m :silent Make<CR>

" Switch from header to source and viceversa
nnoremap <F4> :A<CR>

nnoremap <F12> :colorscheme Tomorrow<enter>:TOhtml<enter>:colorscheme hybrid_material<enter>:w<enter>:!open file://%:p<enter>:sleep 1<enter>:!rm %:p<enter>:q<enter><enter>

autocmd filetype cpp setl makeprg=make
autocmd filetype elixir setl makeprg=mix\ compile

set path=.,,**
set suffixesadd=".cpp .hpp .java .php .html"

autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :silent <C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :slilent ClangFormat<CR>

set tags=~/.vim/.vimtags

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

set t_Co=256
let g:enable_bold_font = 1
colorscheme hybrid_material
let g:airline_theme = 'hybrid'
let g:airline_powerline_fonts = 1

highlight MatchParen gui=bold,underline,italic term=underline guibg=NONE guifg=white ctermbg=none ctermfg=none

" Enable line highlighting on insert
autocmd InsertEnter,InsertLeave * set cul!

" Copy and paste operations
inoremap <C-v> <C-o>"+p
nnoremap <C-v> "+p
vmap <C-c> "+y
vmap <C-x> "+c
vmap <C-v> c<C-o>"+p

nnoremap <silent> <C-l> :nohl<CR><C-l>

noremap 0 ^
noremap ^ 0

noremap [ {
noremap ] }

inoremap jj <ESC>

map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
nmap s <Plug>(easymotion-s2)

nmap <Leader>w :w<CR>
nmap <Leader>e :CtrlPMixed<CR>
nmap <Leader>q :q<CR>
nmap <Leader>k :bd<CR>
nmap <Leader>n :enew<CR>
nmap <Leader>f <C-w><C-f>

nmap gs :Gstatus<CR>
nmap gb :Gbr<CR>
nmap gv :Gbrowse<CR>
nmap gp :Git pull<CR>
nmap gP :Git push<CR>

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
let g:session_autoload = 'no'

map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)

nnoremap ; :

nnoremap j gj
nnoremap k gk

command! W w
command! Q q

set hidden
set foldmethod=syntax
set textwidth=0
set wrapmargin=0
set cursorline
set foldlevel=1
set foldlevelstart=20
set formatoptions=cq
set hlsearch
set incsearch

set laststatus=2
set wrap
set number
set relativenumber
set nobackup
set lazyredraw
set noswapfile
set vb t_vb=
set so=5

set iskeyword-=_
set autoindent
set tabstop=4
set softtabstop=4
set undolevels=1000
set title
set shiftwidth=4
set expandtab
set regexpengine=1
set wildignore=*.so,*.swp,*.zip,*.exe,*.bak,*.class

autocmd filetype scss set sw=2
autocmd filetype yaml set sw=2
autocmd filetype go set ts=4 sw=4 sts=4 noexpandtab

if(exists('breakindent'))
    set breakindent
endif

" Indent guides
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 1
let g:indent_guides_enable_on_vim_startup = 1

" CtrlP
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = 'node_modules\|vendor\|app_release\|public\/js\|_projects\|_builds\|_temp'

" quick-scope
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" ag.vim
let g:ag_working_path_mode="ra"

set autoread

if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
