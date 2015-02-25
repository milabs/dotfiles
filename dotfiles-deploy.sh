#!/bin/sh

dotfiles=$(dirname $(readlink -f $0))

# Xresources
ln -sf $dotfiles/.Xresources $HOME
ln -sf $dotfiles/.Xresources.* $HOME

# awesome WM
mkdir -p $HOME/.config/awesome
cp -sru $dotfiles/.config/awesome $HOME/.config
