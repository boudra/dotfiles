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
      vim.api.nvim_out_write("treeenvim\n")
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
  }

  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
  }

  use({ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' })

  use 'nvimtools/none-ls.nvim'
  use 'nvimtools/none-ls-extras.nvim'

  use {
    "yetone/avante.nvim",
    opts = {
      -- add any opts here
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    requires = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua",      -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        -- Changed from VeryLazy (lazy.nvim) to BufReadPost (packer.nvim compatible)
        event = "BufReadPost",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  }


  -- use({
  --   "robitx/gp.nvim",
  --   config = function()
  --   end,
  -- })

  if packer_bootstrap then
    require('packer').sync()
  end
end)
