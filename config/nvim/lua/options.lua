vim.cmd("colorscheme catppuccin")

-- vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.startify_change_to_vcs_root = 0
vim.g.startify_session_autoload = 0
vim.g.startify_change_to_dir = 0

-- vim.opt.clipboard     = "unnamedplus"
vim.opt.undofile      = true -- persistent undo
vim.opt.backup        = false -- disable backup
vim.opt.cursorline    = true -- enable cursor line
vim.opt.expandtab     = true -- use spaces instead of tabs
vim.opt.autowrite     = true -- auto write buffer when it's not focused
vim.opt.hidden        = true -- keep hidden buffers
vim.opt.autoread      = true -- auto read file when it's changed outside of vim
vim.opt.hlsearch      = true -- highlight matching search
vim.opt.incsearch     = true -- show search matches as you type
vim.opt.tabstop       = 2 -- number of spaces tabs count for
vim.opt.ignorecase    = true -- case insensitive on search..
vim.opt.smartcase     = true -- ..unless there's a capital
vim.opt.equalalways   = true -- make window size always equal
vim.opt.lazyredraw    = true -- make macro faster
vim.opt.list          = true -- display listchars
vim.opt.number        = true -- show line numbers
vim.opt.numberwidth   = 3 -- set number column width to 2
vim.opt.showmode      = false -- don't show mode
vim.opt.autoindent    = true -- enable autoindent
vim.opt.smartindent   = true -- smarter indentation
vim.opt.smarttab      = true -- make tab behaviour smarter
vim.opt.splitbelow    = true -- split below instead of above
vim.opt.splitright    = true -- split right instead of left
vim.opt.splitkeep     = "screen" -- stabilize split
vim.opt.startofline   = false -- don't go to the start of the line when moving to another file
vim.opt.swapfile      = false -- disable swapfile
vim.opt.termguicolors = true -- true colours for better experience
vim.opt.wrap          = false -- don't wrap lines
vim.opt.writebackup   = false -- disable backup
vim.opt.swapfile      = false -- disable swap
vim.opt.backupcopy    = "yes" -- fix weirdness for stuff that replaces the entire file when hot reloading
vim.opt.autochdir     = false -- change directory to current file
vim.opt.completeopt   = {
  "menu",
  "menuone",
  "noselect",
  "noinsert",
} -- better completion
vim.opt.encoding      = "UTF-8" -- set encoding
vim.opt.fillchars     = {
  vert = "│",
  eob = " ",
  fold = " ",
  diff = " ",
} -- make vertical split sign better
vim.opt.inccommand    = "split" -- incrementally show result of command
vim.opt.listchars     = {
  tab = "» ",
} -- set listchars
vim.opt.mouse         = "nvi" -- enable mouse support in normal, insert, and visual mode
vim.opt.shortmess     = "csa" -- disable some stuff on shortmess
vim.opt.signcolumn    = "yes" -- enable sign column all the time 4 column
vim.opt.laststatus    = 2 -- always enable statusline
vim.opt.pumheight     = 10 -- limit completion items
vim.opt.re            = 0 -- set regexp engine to auto
vim.opt.scrolloff     = 2 -- make scrolling better
vim.opt.sidescroll    = 2 -- make scrolling better
vim.opt.shiftwidth    = 2 -- set indentation width
vim.opt.sidescrolloff = 15 -- make scrolling better
vim.opt.tabstop       = 2 -- tabsize
vim.opt.timeoutlen    = 400 -- faster timeout wait time
vim.opt.updatetime    = 1000 -- set faster update time
vim.opt.joinspaces    = false
vim.opt.diffopt:append { "algorithm:histogram", "indent-heuristic" }
