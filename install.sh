#!/bin/sh

home=home

cd
ln -s $home/.emacs .emacs
ln -s $home/.emacs.d .emacs.d
ln -s $home/.vim .vim
test -f .vimrc && mv .vimrc .vimrc-bak
ln -s $home/.vimrc .vimrc
ln -s $home/bin bin

echo "source \$HOME/home/.prompt" >> .bash_profile
echo >> .bash_profile
cat $home/aliases >> $HOME/.bash_profile

git config --global user.name "Moxley Stratton"
git config --global user.email "moxley.stratton@gmail.com"

