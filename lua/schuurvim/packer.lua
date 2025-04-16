-- This file can be loaded by calling `lua require('plugins')` from your init.vim
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.3',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    -- Color schemes
    -- ----------------------------------------------------
    use {
        'rebelot/kanagawa.nvim',
        as = "kanagawa",
        --config = function()
        --vim.cmd('colorscheme kanagawa')
        --end
    }
    use { "neanias/everforest-nvim", as = "everforest" }
    use { "Shatur/neovim-ayu", as = "ayu" }
    use { "wadackel/vim-dogrun", as = "dogrun" }
    use { "easymotion/vim-easymotion" } -- Super fast vim motions
    use { "ghifarit53/tokyonight-vim", as = "tokyonight" }
    use { "catppuccin/nvim", as = "catppuccin" }
    --use { "JoosepAlviste/palenightfall.nvim", as = "palenightfall",
    --    config = function()
    --        require('palenightfall').setup({
    --            color_overrides = {
    --                references = '#3E4B6E',
    --                highlight  = '#3F4654'
    --            }
    --        })
    --    end
    --}
    use 'marko-cerovac/material.nvim'
    use({
        "epwalsh/obsidian.nvim",
        tag = "*", -- recommended, use latest release instead of latest commit
        requires = {
            -- Required.
            "nvim-lua/plenary.nvim",
            "hrsh7th/nvim-cmp",
            "nvim-telescope/telescope.nvim",
        },
    })
    use { "nvim-telescope/telescope-bibtex.nvim",
        requires = {
            { 'nvim-telescope/telescope.nvim' },
        },
    }
    --use { "/home/mathijs/side-projects/forks/telescope-bibtex.nvim",
    --      requires = {
    --            {'nvim-telescope/telescope.nvim'},
    --    },
    --}
    use('junegunn/goyo.vim')                                          -- Zen-mode in nvim
    use { 'akinsho/git-conflict.nvim', tag = "*", config = function() -- Fix merge conflicts
        require('git-conflict').setup()
    end }
    -----------------------------------------------------------
    use('preservim/nerdcommenter')
    use('unblevable/quick-scope') -- highlight characters for quick horizontal movements
    use('mbbill/undotree')
    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use('nvim-treesitter/nvim-treesitter-context')
    use({
        "nvim-treesitter/nvim-treesitter-textobjects",
        after = "nvim-treesitter",
        requires = "nvim-treesitter/nvim-treesitter",
    })                        -- Text objects and motions using treesitter.
    use('tpope/vim-fugitive') -- Git integration
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' }, -- Required
            {
                -- Optional
                'williamboman/mason.nvim',
                run = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp',
                -- commit = "8b76965ed05016a3596b1d4d685c7b5caf1062a5" },     -- Required
            },
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'L3MON4D3/LuaSnip' },     -- Required: snippets
        }
    }
    use {
        "ray-x/lsp_signature.nvim",
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
    use('norcalli/nvim-colorizer.lua')     -- Syntax colors
    use('airblade/vim-gitgutter')          -- Gutter with git information
    use { 'lervag/vimtex', tag = 'v2.15' } -- LaTeX support
    if vim.loop.os_uname().sysname ~= "Darwin" then
        use('peterbjorgensen/sved')        -- Fixes reverse syncing with latex in evince
    end
    --use { 'freddiehaddad/feline.nvim',           -- Nice statusbar
    --requires = { 'lewis6991/gitsigns.nvim' } -- For git info
    --}
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }
    use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' } -- Nice diff view
    use { 'nvim-pack/nvim-spectre',                                      -- Project-wide search and replace
        requires = { 'nvim-lua/plenary.nvim' }
    }
    use { 'ThePrimeagen/harpoon',
        requires = { 'nvim-lua/plenary.nvim' }
    }
    use({
        -- Change/add/delete surrounding brackets etc.
        "kylechui/nvim-surround",
        tag = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    })
    use("puremourning/vimspector") -- Debuggers
    use { "sagi-z/vimspectorpy",   -- Python debugging
        --config = function()
        --pcall(vim.cmd, "VimspectorpyUpdate")
        --end } -- Python debugging
    }
    --use { "gennaro-tedesco/nvim-possession", -- Store and load vim sessions
    --    requires = { "ibhagwan/fzf-lua" },
    --    config = function() require("nvim-possession").setup({}) end
    --}
    use { 'superDross/run-with-me.vim' } -- Run scripts in integrated terminal
    use { 'nanozuki/tabby.nvim' }        -- Pretty tabs in nvim
    use {                                -- Autogenerate documentation
        'kkoomen/vim-doge',
        run = ':call doge#install()'
    }
    use 'rcarriga/nvim-notify' -- Nicer notifications
    --use { 'mrcjkb/rustaceanvim',
    --      version = '^4', -- Recommended
    --      ft = { 'rust' },
    --}
    use "stevearc/oil.nvim"       -- Edit directory as a buffer
    use "jupyter-vim/jupyter-vim" -- Jupyter notebook integration
    use "nvim-telescope/telescope-symbols.nvim"

      -- Automatically set up your configuration after cloning packer.nvim
      -- Put this at the end after all plugins
      if packer_bootstrap then
        require('packer').sync()
      end
end
)
