#!/bin/sh

dotfiles=$(dirname $(readlink -f $0))

# Xresources
ln -sf $dotfiles/.Xresources $HOME
ln -sf $dotfiles/.Xresources.* $HOME

# i3wm
cp -sru $dotfiles/config/i3 $HOME/.config/
cp -sru $dotfiles/config/i3status $HOME/.config/

# emacs OS
mkdir -p $HOME/.emacs.d
cp -sru $dotfiles/.emacs.d $HOME/

# gitk
ln -sf $dotfiles/.gtkrc-2.0 $HOME/
