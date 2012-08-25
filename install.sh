#!/bin/zsh

cp -u .emacs .pentadactylrc .vimrc .xinitrc .Xmodmap .Xresources .xscreensaver .xsession .zshrc $HOME/

## copy to dir if not have dir then mkdir and copy. 
cp -u rc.lua $HOME/.config/awesome ||  (mkdir -p $HOME/.config/awesome && cp -u rc.lua $HOME/.config/awesome) 
