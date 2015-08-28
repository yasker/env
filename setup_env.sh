#!/bin/bash

sudo apt-get install build-essential cmake
sudo apt-get install python-dev
cp ./.vimrc ~
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
cd ~/.vim/bundle/YouCompleteMe/
./install.py --gocode-completer --clang-completer
