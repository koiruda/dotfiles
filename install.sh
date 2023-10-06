#!/bin/bash

set -ue

DOTPATH="${HOME}/dotfiles"
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

if [ ! -d "${XDG_CONFIG_HOME}" ]; then
    mkdir -p "${XDG_CONFIG_HOME}"
fi

if [ ! -d "${XDG_CACHE_HOME}" ]; then
    mkdir -p "${XDG_CACHE_HOME}"
fi

if [ ! -d "${XDG_DATA_HOME}" ]; then
    mkdir -p "${XDG_DATA_HOME}"
fi

if [ ! -d "${XDG_STATE_HOME}" ]; then
    mkdir -p "${XDG_STATE_HOME}"
fi

sudo apt update
sudo apt upgrade -y
sudo apt install -y curl git make tig vim shellcheck expect file fd-find ripgrep bat exa zoxide zsh \
    socat # for wsl

echo "Installing latest neovim..."
wget -P /tmp/ https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
tar -zxvf /tmp/nvim-linux64.tar.gz -C /tmp/
sudo mv /tmp/nvim-linux64/ /usr/local/
sudo ln -sfn /usr/local/nvim-linux64/bin/nvim /usr/local/bin/nvim

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

DIFF_HIGHLIGHT_HOME="/usr/share/doc/git/contrib/diff-highlight"
if [ -d "${DIFF_HIGHLIGHT_HOME}" ]; then
    if [ ! -f "${DIFF_HIGHLIGHT_HOME}/diff-highlight" ]; then
        echo "Installing diff-highlight..."
        cd "${DIFF_HIGHLIGHT_HOME}"
        sudo make
        sudo ln -s /usr/share/doc/git/contrib/diff-highlight/diff-highlight /usr/local/bin/diff-highlight
    fi
fi

cd ~/
source "${DOTPATH}/configure.sh"
sudo chsh -s /usr/bin/zsh

# Disable shell activate as it does not work in WSL
# exec "$SHELL" -l
