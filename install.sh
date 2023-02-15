#!/bin/bash

set -ue

DOTPATH=~/dotfiles
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

sudo apt update
sudo apt upgrade
sudo apt install -y curl git tig vim shellcheck expect file fd-find ripgrep bat exa zoxide zsh \
    socat # for wsl

echo "Installing latest neovim..."
wget -P /tmp https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.deb && \
sudo apt install /tmp/nvim-linux64.deb -y && \
rm /tmp/nvim-linux64.deb

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ -d "${ZINIT_HOME}" ]; then
    echo "zinit is already installed."
    git -C "${ZINIT_HOME}" pull
else
    echo "Installing zinit..."
    git clone https://github.com/zdharma-continuum/zinit.git "${ZINIT_HOME}"
fi

cd ~/

source "${DOTPATH}/configure.sh"

sudo chsh -s /usr/bin/zsh

exec "$SHELL" -l
