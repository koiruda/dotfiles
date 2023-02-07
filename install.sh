#!/bin/bash

set -ue

DOTPATH=~/dotfiles

sudo apt update
sudo apt upgrade
sudo apt install curl git tig vim zsh -y

wget -P /tmp https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.deb && \
sudo apt install /tmp/nvim-linux64.deb -y && \
rm /tmp/nvim-linux64.deb

cd ~/

source $DOTPATH/configure.sh

chsh -s /usr/bin/zsh

exec $SHELL -l
