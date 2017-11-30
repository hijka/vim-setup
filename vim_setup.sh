#!/bin/bash
mkdir -p ~/.vim
mkdir -p ~/.vim/autoload
rm ~/.vimrc
cat vim_setup.vim >> ~/.vimrc
cp plug.vim ~/.vim/autoload/plug.vim
vim +PlugInstall +q +q
