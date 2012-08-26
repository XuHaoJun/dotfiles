#!/bin/zsh

cp -uv ./{.emacs,.pentadactylrc,.vimrc,.xinitrc,.Xmodmap,.Xresources,.xscreensaver,.xsession,.zshrc,.tmux.conf,.gitconfig} $HOME

## copy to dir if not have dir then mkdir and copy. 
cp -uv rc.lua $HOME/.config/awesome ||  (mkdir -p $HOME/.config/awesome && cp -u rc.lua $HOME/.config/awesome) 
