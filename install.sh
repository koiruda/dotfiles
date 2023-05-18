#!/bin/bash

set -ue

DOTPATH="${HOME}/dotfiles"
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

sudo apt update
sudo apt upgrade
sudo apt install -y curl git tig vim shellcheck expect file fd-find ripgrep bat exa zoxide zsh \
    neovim \
    socat # for wsl

PYENV_HOME="${HOME}/.pyenv"
if [ -d "${PYENV_HOME}" ]; then
    echo "pyenv is already installed."
    git -C "${PYENV_HOME}" pull
else
    echo "Installing pyenv..."
    git clone https://github.com/pyenv/pyenv.git ~/.pyenv
fi

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

# Disable shell activate as it does not work in WSL
# exec "$SHELL" -l
