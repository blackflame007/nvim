-- Install packer
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    _G.packer_bootstrap = fn.system({
        'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path
    })
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
    augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
]]

-- Use a protected call so we don't error out on the first use
local ok_status, packer = pcall(require, 'packer')
if not ok_status then return end

return packer.startup(function(use)
    -- My plugins here
    use 'wbthomason/packer.nvim'
    use 'glepnir/dashboard-nvim'

    -- theme
    use 'morhetz/gruvbox'
    -- Status Line and Bufferline
    use {'romgrk/barbar.nvim', requires = {'kyazdani42/nvim-web-devicons'}}
    use {'nvim-lualine/lualine.nvim', requires = {'kyazdani42/nvim-web-devicons', opt = true}}
    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
            'kyazdani42/nvim-web-devicons' -- optional, for file icon
        },
        config = function()
            require'nvim-tree'.setup {}
        end
    }
    -- lsp
    use {'neovim/nvim-lspconfig', 'williamboman/nvim-lsp-installer'}

    use {
        'L3MON4D3/LuaSnip', 'rafamadriz/friendly-snippets', 'hrsh7th/cmp-nvim-lsp',
        'saadparwaiz1/cmp_luasnip', 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path', 'hrsh7th/cmp-nvim-lua',
        'hrsh7th/cmp-cmdline', 'hrsh7th/cmp-vsnip', 'hrsh7th/vim-vsnip', 'onsails/lspkind-nvim'
    }
    use 'jose-elias-alvarez/null-ls.nvim'
    use 'hrsh7th/nvim-cmp' -- completion
    use {'tzachar/cmp-tabnine', run = './install.sh', requires = 'hrsh7th/nvim-cmp'}
    use 'simrat39/symbols-outline.nvim'

    use 'sbdchd/neoformat'
    use 'prettier/vim-prettier'
    -- Telescope
    use {'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/plenary.nvim'}, {'nvim-lua/popup.nvim'}}}
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
    use 'ThePrimeagen/git-worktree.nvim'
    -- Treesitter
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use 'nvim-treesitter/playground'
    -- gitsigns

    use {'lewis6991/gitsigns.nvim', requires = {'nvim-lua/plenary.nvim'}}

    -- Comments
    use {
        'numToStr/Comment.nvim',
        requires = {{'JoosepAlviste/nvim-ts-context-commentstring'}},
        config = function()
            require('Comment').setup()
        end
    }

    -- which-key
    use {
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup {}
        end
    }

    -- Autopairs
    use 'windwp/nvim-autopairs'
    use 'tpope/vim-sleuth'
    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then require('packer').sync() end
end)

