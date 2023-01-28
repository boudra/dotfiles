require("options")
require("plugins")
require("completion")
require("lsp")
require("keymaps")

vim.cmd("colorscheme catppuccin")

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

ProjectFiles = function()
  local ok = pcall(require 'telescope.builtin'.git_files, {
    show_untracked = true
  })

  if not ok then require 'telescope.builtin'.find_files {
      find_command = { 'rg', '--files', '--iglob', '!.git', '--hidden' },
    }
  end
end

telescope.setup { defaults = {
  mappings = {
    i = {
      ["<C-j>"] = "move_selection_next",
      ["<C-k>"] = "move_selection_previous"
    }
  }
} }


-- empty setup using defaults
require("nvim-tree").setup()


-- OR setup with some options
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
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
      { 'mode', 'paste' },
      { 'gitbranch', 'readonly', 'filename', 'modified' }
    },
  },
  component_function = {
    gitbranch = 'FugitiveHead',
  },
}

vim.g["easymotion_smartcase"] = 1
vim.g["easymotion_use_smartsign_us"] = 1
