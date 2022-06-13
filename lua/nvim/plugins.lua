local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path
    }
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then return end

-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float {border = "rounded"}
        end
    }
}

return packer.startup(function(use)
    -- General Plugins
    use 'wbthomason/packer.nvim'
    use 'goolord/alpha-nvim'
    use "antoinemadec/FixCursorHold.nvim" -- This is needed to fix lsp doc highlight
    use "folke/which-key.nvim"
    use "ahmedkhalf/project.nvim"
    use "lukas-reineke/indent-blankline.nvim"
    use "moll/vim-bbye"
    use "windwp/nvim-spectre"
    use "folke/zen-mode.nvim"
    use "karb94/neoscroll.nvim"
    use "folke/todo-comments.nvim"
    use "kevinhwang91/nvim-bqf"
    use "ThePrimeagen/harpoon"
    use "tamago324/lir.nvim"
    use "MattesGroeger/vim-bookmarks"
    use "Mephistophiles/surround.nvim"
    use "tpope/vim-repeat"
    use "rcarriga/nvim-notify"
    use "tversteeg/registers.nvim"
    -- use "metakirby5/codi.vim"
    use {"nyngwang/NeoZoom.lua", branch = "neo-zoom-original"}
    use {"christianchiarulli/nvim-gps", branch = "text_hl"}
    use {"michaelb/sniprun", run = "bash ./install.sh"}
    use "akinsho/bufferline.nvim"
    use {'romgrk/barbar.nvim', requires = {'kyazdani42/nvim-web-devicons'}}
    use {'nvim-lualine/lualine.nvim', requires = {'kyazdani42/nvim-web-devicons', opt = true}}
    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
            'kyazdani42/nvim-web-devicons' -- optional, for file icon
        }
    }
    use {"iamcco/markdown-preview.nvim", run = "cd app && npm install", ft = "markdown"}
    use {
        "christianchiarulli/JABS.nvim",
        requires = {"kyazdani42/nvim-web-devicons"} -- optional
    }
    -- terminal
    use 'akinsho/toggleterm.nvim'

    -- theme
    use 'morhetz/gruvbox'

    -- cmp plugins
    -- use "hrsh7th/nvim-cmp" -- The completion plugin
    use {
        "hrsh7th/nvim-cmp"
        -- commit = "dbc72290295cfc63075dab9ea635260d2b72f2e5",
    }
    use "hrsh7th/cmp-buffer" -- buffer completions
    use "hrsh7th/cmp-path" -- path completions
    use "hrsh7th/cmp-cmdline" -- cmdline completions
    use "saadparwaiz1/cmp_luasnip" -- snippet completions
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-emoji"
    use "hrsh7th/cmp-nvim-lua"
    use "rcarriga/cmp-dap"
    use {
        "tzachar/cmp-tabnine",
        config = function()
            local tabnine = require "cmp_tabnine.config"
            tabnine:setup{
                max_lines = 1000,
                max_num_results = 20,
                sort = true,
                run_on_every_keystroke = true,
                snippet_placeholder = "..",
                ignored_file_types = { -- default is not to ignore
                    -- uncomment to ignore in lua:
                    -- lua = true
                }
            }
        end,

        run = "./install.sh",
        requires = "hrsh7th/nvim-cmp"
    }

    -- use 'David-Kunz/cmp-npm' -- doesn't seem to work

    -- snippets
    use "L3MON4D3/LuaSnip" -- snippet engine
    use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

    -- LSP
    use "neovim/nvim-lspconfig" -- enable LSP
    use "williamboman/nvim-lsp-installer" -- simple to use language server installer
    use "onsails/lspkind-nvim"
    use "tamago324/nlsp-settings.nvim" -- language server settings defined in json for
    use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters
    use "filipdutescu/renamer.nvim"
    use "simrat39/symbols-outline.nvim"
    use "ray-x/lsp_signature.nvim"
    use "b0o/SchemaStore.nvim"
    use {"folke/trouble.nvim", cmd = "TroubleToggle"}
    use "github/copilot.vim"
    use "RRethy/vim-illuminate"

    use 'sbdchd/neoformat'
    use 'prettier/vim-prettier'
    -- Telescope
    use {'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/plenary.nvim'}, {'nvim-lua/popup.nvim'}}}
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
    use 'ThePrimeagen/git-worktree.nvim'

    -- Treesitter
    use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
    use "JoosepAlviste/nvim-ts-context-commentstring"
    use {"p00f/nvim-ts-rainbow"}
    -- use {'christianchiarulli/nvim-ts-rainbow'}
    use "nvim-treesitter/playground"
    use "windwp/nvim-ts-autotag"
    use "romgrk/nvim-treesitter-context"
    use "mizlan/iswap.nvim"

    -- Git
    use "lewis6991/gitsigns.nvim"
    use "f-person/git-blame.nvim"
    use "ruifm/gitlinker.nvim"
    use "mattn/vim-gist"
    use "mattn/webapi-vim"
    use "https://github.com/rhysd/conflict-marker.vim"
    -- Comments
    use {
        'numToStr/Comment.nvim',
        requires = {{'JoosepAlviste/nvim-ts-context-commentstring'}},
        config = function()
            require('Comment').setup()
        end
    }

    -- Autopairs
    use 'windwp/nvim-autopairs'
    use 'tpope/vim-sleuth'

    -- DAP
    use "mfussenegger/nvim-dap"
    use "theHamsta/nvim-dap-virtual-text"
    use "rcarriga/nvim-dap-ui"
    use "Pocco81/DAPInstall.nvim"

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then require("packer").sync() end
end)

