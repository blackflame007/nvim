#!/bin/bash

git clone https://github.com/neovim/neovim.git ~/neovim

sudo rm /usr/local/bin/nvim
sudo rm -r /usr/local/share/nvim/

cd ~/neovim

make CMAKE_BUILD_TYPE=Release

sudo make install

rm -rf ~/.config/nvim/neovim
