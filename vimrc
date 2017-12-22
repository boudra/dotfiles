if 0 | endif

set encoding=utf-8

if has('win32') || has('win64')
    set runtimepath=$HOME/.vim,$HOME/vimfiles
endif

if &compatible
  set nocompatible
endif
set runtimepath+=~/.vim/bundle/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.vim/bundle')
  call dein#begin('~/.vim/bundle')

  call dein#add('~/.vim/bundle/repos/github.com/Shougo/dein.vim')

  call dein#add('Shougo/vimproc.vim', {'build' : 'make'})
  call dein#add('Shougo/deoplete.nvim')

  call dein#add('ctrlpvim/ctrlp.vim')
  call dein#add('ntpeters/vim-better-whitespace')
  call dein#add('easymotion/vim-easymotion')

  call dein#add('bling/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')
  call dein#add('ayu-theme/ayu-vim')

  call dein#add('slashmili/alchemist.vim')
  call dein#add('elixir-lang/vim-elixir')

  call dein#add('mattn/emmet-vim')
  call dein#add('christoomey/vim-tmux-navigator')
  call dein#add('SirVer/ultisnips')
  call dein#add('honza/vim-snippets')
  call dein#add('mhinz/vim-startify')
  call dein#add('pangloss/vim-javascript')
  call dein#add('mxw/vim-jsx')
  call dein#add('tpope/vim-fugitive')
  call dein#add('tpope/vim-rhubarb')

  call dein#add('tomtom/tcomment_vim')
  call dein#add('elmcast/elm-vim')
  call dein#add('fatih/vim-go')

  call dein#add('terryma/vim-multiple-cursors')

  call dein#end()
  call dein#save_state()
endif

filetype off

let mapleader=","

let g:user_emmet_install_global = 0
autocmd FileType html,css,php,blade,eelixir,scss EmmetInstall
autocmd FileType html,css,php,blade,eelixir,scss imap <Tab> <C-y>,
autocmd FileType html,css,php,blade,eelixir,scss nmap <Tab> <C-y>,
autocmd FileType html,css,php,blade,eelixir,scss vmap <Tab> <C-y>,
" autocmd FileType cpp BufWritePost * Neomake

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
    " Indent guides
    let g:indent_guides_guide_size = 1
    let g:indent_guides_start_level = 1
    let g:indent_guides_enable_on_vim_startup = 1
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

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

set t_Co=256
let g:enable_bold_font = 1
set termguicolors
set background=dark
let ayucolor="dark"
colorscheme ayu
let g:airline_theme = 'hybrid'
let g:airline_powerline_fonts = 1

let g:startify_change_to_vcs_root = 0
let g:startify_session_autoload = 0
let g:startify_change_to_dir = 0

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
nmap <Leader>e :CtrlP<CR>
nmap <Leader>q :q<CR>
nmap <Leader>k :bd<CR>
nmap <Leader>n :enew<CR>
nmap <Leader>f <C-w><C-f>

nmap gs :Gstatus<CR>
nmap gb :Gbr<CR>
nmap gv :Gbrowse<CR>
nmap gP :Dispatch git push<CR>
nmap gp :Dispatch git pull<CR>

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
set nohlsearch
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
set undolevels=1000
set title
set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab
set regexpengine=1
set wildignore=*.so,*.swp,*.zip,*.exe,*.bak,*.class

autocmd filetype scss set sw=2
autocmd filetype yaml set sw=2
autocmd filetype javascript set sw=2
autocmd filetype go set ts=4 sw=4 sts=4 noexpandtab
autocmd filetype elm set sw=4
au BufRead,BufNewFile *.json.mustache setfiletype json

if(exists('breakindent'))
    set breakindent
endif

" CtrlP
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_root_markers = []
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" quick-scope
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" ag.vim
let g:ag_working_path_mode="ra"

set autoread

let g:tmux_navigator_disable_when_zoomed = 1
nnoremap <silent> <BS> :TmuxNavigateLeft<cr>

if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" Italics
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

let g:jsx_ext_required = 0

let g:deoplete#enable_at_startup = 1

let g:elm_format_autosave = 1
let g:elm_format_fail_silently = 1

" ale

let g:ale_lint_on_text_changed = 'never'
let g:ale_sign_column_always = 1

let g:ale_sign_error = 'E'
let g:ale_sign_warning = 'W'

let g:ale_fixers = {
      \ 'elixir': ['remove_trailing_lines', 'trim_whitespace']
      \}
