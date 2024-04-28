require("options")
require("plugins")
require("completion")
require("lsp")
require("keymaps")

vim.cmd("colorscheme catppuccin")

require("mason-lspconfig").setup {
    ensure_installed = { "tsserver", "rust_analyzer" },
}

require 'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "elixir",
    "heex",
    "css",
    "html", "javascript", "typescript", "go", "dockerfile", "rust", "vim", "lua", "solidity",
    "tsx"
  },
  sync_install = false,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

local telescope = require('telescope')

telescope.load_extension('fzf')

telescope.setup { defaults = {
  vimgrep_arguments = {
    "rg",
    "-L",
    "--color=never",
    "--no-heading",
    "--with-filename",
    "--line-number",
    "--column",
    "--smart-case",
    "--hidden",
    "--trim",
    "--glob",
    "!**/.git/*"
  },
  mappings = {
    i = {
      ["<C-j>"] = "move_selection_next",
      ["<C-k>"] = "move_selection_previous",
      ["<esc>"] = "close"
    }
  }
},
  pickers = {
    find_files = {
      find_command = { 'rg', '--files', '-L', '--hidden', '--glob', '!**/.git/*' },
    },
  },
}


-- OR setup with some options
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  update_focused_file = {
	  enable = true,
  },
  view = {
    adaptive_size = true,
    -- mappings = {
    --   list = {
    --     { key = "u", action = "dir_up" },
    --   },
    -- },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

vim.g["lightline"] = {
  colorscheme = 'catppuccin',
  active = {
    left = {
      { 'mode',      'paste' },
      { 'gitbranch', 'readonly', 'filename', 'modified' }
    },
  },
  component_function = {
    gitbranch = 'FugitiveHead',
  },
}

vim.g["easymotion_smartcase"] = 1
vim.g["easymotion_use_smartsign_us"] = 1
