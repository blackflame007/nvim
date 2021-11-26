" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
 Plug 'prettier/vim-prettier'
 Plug 'sbdchd/neoformat'
 Plug 'scrooloose/nerdtree'
 Plug 'mg979/vim-visual-multi', {'branch': 'master'}
 Plug 'Xuyuanp/nerdtree-git-plugin'
 Plug 'ryanoasis/vim-devicons'
 Plug 'pangloss/vim-javascript'
 Plug 'mxw/vim-jsx'
 Plug 'norcalli/nvim-colorizer.lua'
 Plug 'morhetz/gruvbox'

" telescope requirements...
 Plug 'nvim-lua/popup.nvim'
 Plug 'nvim-lua/plenary.nvim'
 Plug 'nvim-telescope/telescope.nvim'
 Plug 'nvim-telescope/telescope-fzy-native.nvim'
 Plug 'ThePrimeagen/git-worktree.nvim'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()


