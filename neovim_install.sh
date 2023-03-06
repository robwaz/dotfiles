#!/bin/bash
wget -O /tmp/neovim.tar.gz 'https://github.com/neovim/neovim/archive/refs/tags/stable.tar.gz'
tar xvf /tmp/neovim.tar.gz -C /tmp
cd /tmp/neovim-stable 
make CMAKE_BUILD_TYPE=RelWithDebInfo 
sudo make install
rm /tmp/neovim.tar.gz
rm -rf /tmp/neovim-stable
