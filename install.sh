#!/bin/bash

set -ue

DOTPATH=~/.dotfiles

sudo apt-get update
sudo apt-get upgrade
sudo apt-get install curl git tig vim zsh -y

cd ~/
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"

source $DOTPATH/configure.sh

chsh -s /usr/bin/zsh

exec $SHELL -l
