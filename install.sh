#!/bin/sh

home=home

cd
ln -s $home/.emacs .emacs
ln -s $home/.emacs.d .emacs.d
ln -s $home/.vim .vim
test -f .vimrc && mv .vimrc .vimrc-bak
ln -s $home/.vimrc .vimrc
ln -s $home/bin bin

