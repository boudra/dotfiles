local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  }

  use 'hrsh7th/cmp-nvim-lsp'
  use "hrsh7th/nvim-cmp"
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/vim-vsnip-integ'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-nvim-lsp-signature-help'

  use "easymotion/vim-easymotion"
  use { "catppuccin/nvim", as = "catppuccin" }

  use 'itchyny/lightline.vim'
  use('christoomey/vim-tmux-navigator')

  use('mhinz/vim-startify')
  use('tpope/vim-fugitive')
  use('tpope/vim-abolish')
  use('tpope/vim-rhubarb')

  use('tomtom/tcomment_vim')
  use('junegunn/goyo.vim')

  use('tpope/vim-surround')
  use('dag/vim-fish')

  use('mg979/vim-visual-multi')

  use('akinsho/toggleterm.nvim')

  use 'folke/trouble.nvim'

  use('nvim-lua/plenary.nvim')
  use('nvim-telescope/telescope.nvim')

  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
  }

  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly'                  -- optional, updated every week. (see issue #1193)
  }

  use({ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' })

  

  use {
    "zbirenbaum/copilot.lua"
  }

  use {
    "zbirenbaum/copilot-cmp",
  }

  use 'jose-elias-alvarez/null-ls.nvim'

  if packer_bootstrap then
    require('packer').sync()
  end
end)
