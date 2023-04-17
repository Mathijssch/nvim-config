-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.1',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  use {
      'rebelot/kanagawa.nvim',
      as = "kanagawa",
      --config = function()
          --vim.cmd('colorscheme kanagawa')
      --end
  }
  use ('rmehri01/onenord.nvim')
  use ('preservim/nerdcommenter')
  use ('mbbill/undotree')
  use ('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate'})
  use ('tpope/vim-fugitive')
  use {
      'VonHeikemen/lsp-zero.nvim',
      branch = 'v2.x',
      requires = {
          -- LSP Support
          {'neovim/nvim-lspconfig'},             -- Required
          {                                      -- Optional
          'williamboman/mason.nvim',
          run = function()
              pcall(vim.cmd, 'MasonUpdate')
          end,
      },
      {'williamboman/mason-lspconfig.nvim'}, -- Optional

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},     -- Required
      {'hrsh7th/cmp-nvim-lsp'}, -- Required
      {'L3MON4D3/LuaSnip'},     -- Required: snippets
  }
}
use {
  'nvim-tree/nvim-tree.lua',
  requires = {
    'nvim-tree/nvim-web-devicons', -- optional
  },
  config = function()
    require("nvim-tree").setup {}
  end
}
use ('vim-scripts/vim-gitgutter') -- Gutter with git information
use ('lervag/vimtex') -- LaTeX support 
use ('peterbjorgensen/sved') -- Fixes reverse syncing with latex in evince 
use ('feline-nvim/feline.nvim') -- Nice statusbar
use {'nvim-pack/nvim-spectre',
      requires = { 'nvim-lua/plenary.nvim' }
}
end
)
