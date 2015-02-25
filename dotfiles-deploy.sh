#!/bin/sh

dotfiles=$(dirname $(readlink -f $0))

ln -sf $dotfiles/.Xresources $HOME
ln -sf $dotfiles/.Xresources.* $HOME
