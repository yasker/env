#!/bin/bash

sudo apt-get install -y build-essential cmake python-dev ctags
cp ./.vimrc ~
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
cd ~/.vim/bundle/YouCompleteMe/
./install.py --gocode-completer --clang-completer
vim +GoInstallBinaries +qall
