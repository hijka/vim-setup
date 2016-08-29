#!/bin/bash
mkdir -p ~/.vim
mkdir -p ~/.vim/autoload
cat vim_setup.vim >> ~/.vimrc
cp plug.vim ~/.vim/autoload/plug.vim
vim + +PlugInstall +q +q
