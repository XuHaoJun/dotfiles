#!/bin/zsh
dir="$HOME/Dropbox/dotfiles"

cp -uv $HOME/{.emacs,.pentadactylrc,.vimrc,.xinitrc,.Xmodmap,.Xresources,.xscreensaver,.xsession,.xbindkeysrc,.zshrc,.tmux.conf,.gitconfig,.gtkrc-2.0} $dir
cp -uv $HOME/.config/awesome/rc.lua $dir
cp -uv $HOME/.irssi/config $dir/.irssi
## default dir is awesome my customize theme
## must use sudo cp -ru /usr/share/awesome/themes/default .
