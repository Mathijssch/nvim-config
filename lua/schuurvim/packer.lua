-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
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
    use('rmehri01/onenord.nvim')
    use { "wadackel/vim-dogrun", as = "dogrun" }
    use { "ghifarit53/tokyonight-vim", as = "tokyonight" }
    use { "catppuccin/nvim", as = "catppuccin" }
    use { "JoosepAlviste/palenightfall.nvim", as = "palenightfall",
        config = function()
            require('palenightfall').setup({
                color_overrides = {
                    references = '#3E4B6E',
                    highlight  = '#3F4654'
                }
            })
        end
    }
    -----------------------------------------------------------
    use('preservim/nerdcommenter')
    use('mbbill/undotree')
    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use({
        "nvim-treesitter/nvim-treesitter-textobjects",
        after = "nvim-treesitter",
        requires = "nvim-treesitter/nvim-treesitter",
    }) -- Text objects and motions using treesitter.
    use('tpope/vim-fugitive')
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
            { 'hrsh7th/nvim-cmp' },     -- Required
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
    --use('vim-scripts/vim-gitgutter')             -- Gutter with git information
    use('lervag/vimtex')                         -- LaTeX support
    use('peterbjorgensen/sved')                  -- Fixes reverse syncing with latex in evince
    use { 'freddiehaddad/feline.nvim',           -- Nice statusbar
        requires = { 'lewis6991/gitsigns.nvim' } -- For git info
    }
    use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' } -- Nice diff view
    use { 'nvim-pack/nvim-spectre',
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
    use { "gennaro-tedesco/nvim-possession",
        requires = { "ibhagwan/fzf-lua" },
        config = function() require("nvim-possession").setup({}) end
    }
    use {'superDross/run-with-me.vim'}  -- Run scripts in integrated terminal 
    use {'nanozuki/tabby.nvim'}         -- Pretty tabs in nvim
    use {                               -- Autogenerate documentation
        'kkoomen/vim-doge',
        run = ':call doge#install()'
    }
    use 'rcarriga/nvim-notify'          -- Nicer notifiations
end
)
