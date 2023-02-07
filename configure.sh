#!/bin/bash

set -ue

DOTPATH=~/dotfiles

cd ~/dotfiles

for f in .??*
do
    [ "$f" = ".git" ] && continue

    ln -snfv "$DOTPATH/$f" "$HOME/$f"
done

mkdir -p ~/.config/nvim
ln -snfv $DOTPATH/.vimrc ~/.config/nvim/init.vim

