#!/bin/zsh
dir="$HOME/Dropbox/dotfiles"

cp -uv $HOME/{.emacs,.pentadactylrc,.vimrc,.xinitrc,.Xmodmap,.Xresources,.xscreensaver,.xsession,.xbindkeysrc,.zshrc,.tmux.conf,.gitconfig} $dir
cp -uv $HOME/.config/awesome/rc.lua $dir

## default dir is awesome my customize theme
## must use sudo cp -ru /usr/share/awesome/themes/default .
