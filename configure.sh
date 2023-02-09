#!/bin/bash

set -ue

DOTPATH=~/dotfiles
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

mkdir -p "${XDG_CONFIG_HOME}/zsh"
ln -snfv "${DOTPATH}/config/zsh/.zshenv" "${XDG_CONFIG_HOME}/zsh/.zshenv"
ln -snfv "${DOTPATH}/config/zsh/.zshrc" "${XDG_CONFIG_HOME}/zsh/.zshrc"
ln -snfv "${DOTPATH}/config/zsh/.zshrc.lazy" "${XDG_CONFIG_HOME}/zsh/.zshrc.lazy"
ln -snfv "${DOTPATH}/config/zsh/.p10k.zsh" "${XDG_CONFIG_HOME}/zsh/.p10k.zsh"

ln -sfv "$XDG_CONFIG_HOME/zsh/.zshrc" "${HOME}/.zshrc"
ln -sfv "$XDG_CONFIG_HOME/zsh/.zshenv" "${HOME}/.zshenv"

cd "${DOTPATH}"

for f in .??*
do
    [ "${f}" = ".git" ] && continue

    ln -snfv "${DOTPATH}/$f" "${HOME}/$f"
done

# Link vimrc to init.vim
mkdir -p ~/.config/nvim
ln -snfv "${DOTPATH}/.vimrc" "${XDG_CONFIG_HOME}/nvim/init.vim"
