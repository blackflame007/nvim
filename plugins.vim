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
" Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }

" List ends here. Plugins become visible to Vim after this call.
call plug#end()


