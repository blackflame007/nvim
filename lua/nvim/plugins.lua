local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)
  -- My plugins here
  use 'wbthomason/packer.nvim'
  use 'glepnir/dashboard-nvim'
  -- Status Line and Bufferline
  use {
  'romgrk/barbar.nvim',
  requires = {'kyazdani42/nvim-web-devicons'}
  }
  use {
  'nvim-lualine/lualine.nvim',
  requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }
  -- lsp
  use {
    'neovim/nvim-lspconfig',
    'williamboman/nvim-lsp-installer',
  }
-- Telescope
  use {
   'nvim-telescope/telescope.nvim',
   requires = { 
	   	{'nvim-lua/plenary.nvim'},
		{'nvim-lua/popup.nvim'}
	   }
  }
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    -- Treesitter
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use {
    'numToStr/Comment.nvim',
    requires = { {'JoosepAlviste/nvim-ts-context-commentstring'} },
    config = function()
        require('Comment').setup()
    end
  } 
  -- Autopairs
  use 'windwp/nvim-autopairs'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)


