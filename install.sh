#!/bin/bash

set -ue

DOTPATH=~/.dotfiles

cd ~/.dotfiles

sudo apt-get update
sudo apt-get upgrade
sudo apt-get install git tig vim zsh

source ./configure.sh

chsh -s /usr/bin/zsh

exec $SHELL -l
