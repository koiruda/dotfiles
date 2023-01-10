#!/bin/bash

set -ue

DOTPATH=~/dotfiles

sudo apt-get update
sudo apt-get upgrade
sudo apt-get install curl git tig vim zsh -y

cd ~/

source $DOTPATH/configure.sh

chsh -s /usr/bin/zsh

exec $SHELL -l
