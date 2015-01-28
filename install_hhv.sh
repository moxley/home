#!/bin/bash

# Install home directory for Househappy Vagrant

if [ ! -f ~/.home_config ]; then
  echo "MERGE_USER=househappy" >> ~/.home_config
  echo "MERGE_BRANCH=development" >> ~/.home_config
fi

if [ ! -f ~/bin/command_server ]; then
  ln -s ~/moxley_home/bin/command_server ~/bin/command_server
fi
