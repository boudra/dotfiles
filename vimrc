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
NeoBundle 'Shougo/neocomplete'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'bling/vim-airline'
NeoBundle 'MarcWeber/vim-addon-mw-utils'
NeoBundle 'tomtom/tlib_vim'
NeoBundle 'ervandew/supertab'
NeoBundle 'SirVer/ultisnips'
NeoBundle 'honza/vim-snippets'
NeoBundle 'rhysd/vim-clang-format'
NeoBundle 'a.vim'
NeoBundle 'octol/vim-cpp-enhanced-highlight'
NeoBundle 'xolox/vim-misc'
NeoBundle 'xolox/vim-easytags'
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
NeoBundle 'fugitive.vim'
NeoBundle 'airblade/vim-gitgutter'
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

" Javascript
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'othree/javascript-libraries-syntax.vim'
NeoBundle 'leafgarland/typescript-vim'
NeoBundle 'burnettk/vim-angular'
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

call neobundle#end()

NeoBundleCheck

let g:angular_filename_convention = 'titlecased'

let mapleader=","

" Bind C-j to Emmet expander
imap <C-j> <C-y>,
vmap <C-j> <C-y>,
nmap <C-j> <C-y>,

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

" Switch from header to source and viceversa
nnoremap <F4> :A<CR>

nnoremap <F12> :colorscheme Tomorrow<enter>:TOhtml<enter>:colorscheme hybrid_material<enter>:w<enter>:!firefox file://%:p<enter>:!rm %:p<enter>:q<enter><enter>

autocmd filetype cpp setl makeprg=make\ -j9\ -C\ ../build

set path=.,,**
set suffixesadd=".cpp .hpp .java .php .html"

let g:mta_filetypes = {
    \ 'html'  : 1,
    \ 'xhtml' : 1,
    \ 'xml'   : 1,
    \ 'jinja' : 1,
	\ 'php'   : 1,
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
let g:syntastic_cpp_compiler_options = '-std=c++11 -Wall -Wno-long-long -pedantic'
let g:syntastic_auto_loc_list = 1
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }

let g:easytags_events = ['BufWritePost']
let g:easytags_async = 1
let g:easytags_dynamic_files = 2
set tags=~/.vim/.vimtags

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

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

noremap 0 ^
noremap ^ 0

noremap [ {
noremap ] }

inoremap jj <ESC>

map <Leader>j <Plug>(easymotion-j)

map <Leader>k <Plug>(easymotion-k)
nmap s <Plug>(easymotion-s2)

nmap <Leader>w :w<CR>
nmap <Leader>e :CtrlP<CR>
nmap <Leader>b :CtrlPBuffer<CR>
nmap <Leader>q :q<CR>
nmap <Leader>k :bd<CR>
nmap <Leader>f <C-w><C-f>

nmap gs :Gstatus<CR>
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

let g:dbgPavimPort = 9009
let g:dbgPavimBreakAtEntry = 0

"nmap <Tab> :NERDTreeToggle<CR>
"imap <Tab> <Plug>snipMateTrigger

set foldmethod=syntax
set textwidth=0
set wrapmargin=0
set cursorline
set foldlevel=1
set foldlevelstart=20
set formatoptions=cq

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
set smartindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set regexpengine=1
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

autocmd filetype scss set sw=2
autocmd filetype go set ts=4 sw=4 sts=4 noexpandtab

if(exists('breakindent'))
	set breakindent
endif


"#####################
"# Neocomplete
"#####################

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 0
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 4
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif

let g:indent_guides_guide_size = 1

let g:used_javascript_libs = 'jquery,angularjs,angularui,underscore,lodash'

" CtrlP
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = 'node_modules\|vendor\|app_release\|public\/js'

" Javascript
let g:javascript_conceal_function   = "ƒ"
let g:javascript_conceal_null       = "ø"
let g:javascript_conceal_this       = "@"
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_typescript_checkers = ['tslint', 'tsc']


" quick-scope
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" ag.vim
let g:ag_working_path_mode="ra"

set autoread
