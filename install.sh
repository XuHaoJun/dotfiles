#!/bin/zsh

cp -av ./{.emacs,.pentadactylrc,.vimrc,.xinitrc,.Xmodmap,.Xresources,.xscreensaver,.xsession,.zshrc,.tmux.conf,.gitconfig} $HOME

## copy to dir if not have dir then mkdir and copy. 
cp -av rc.lua $HOME/.config/awesome/ ||  (mkdir -p $HOME/.config/awesome && cp -av rc.lua $HOME/.config/awesome) 
