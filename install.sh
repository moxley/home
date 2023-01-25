#!/bin/sh

home=home

cd
ln -s $home/bin bin
ln -s $home/.zshrc ~/.zshrc

git config --global user.name "Moxley Stratton"
git config --global user.email "moxley.stratton@gmail.com"

