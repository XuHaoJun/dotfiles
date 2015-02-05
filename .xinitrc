#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

#### start my settings
export BROWSER=firefox

# input method
export GTK_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export QT_IM_MODULE=fcitx
export GTK_MODULE=fcitx
export QT_MODULE=fcitx
export G_FILENAME_ENCODING=@utf8
#export XIM_PROGRAM="fcitxn"
export LC_CTYPE="zh_TW.utf8"

if test -f $HOME/.Xmodmap && hash xmodmap 2>/dev/null; then
    xmodmap $HOME/.Xmodmap
fi

if test -f $HOME/.Xresources && hash xrdb 2>/dev/null; then
    xrdb $HOME/.Xresources
fi

if test -f $HOME/.xbindkeysrc && hash xbindkeys 2>/dev/null; then
    xbindkeys -f $HOME/.xbindkeysrc
fi

xset r rate 200 30
xsetroot -cursor_name left_ptr

if hash urxvtd 2>/dev/null; then
    urxvtd -f -o -q
fi
if hash dropboxd 2>/dev/null; then
    dropboxd &
fi
if hash xcmenu 2>/dev/null; then
    xcmenu --daemon
fi
if hash xscreensaver 2>/dev/null; then
    xscreensaver -no-splash &
    if hash lightsOn 2>/dev/null; then
        lightsOn &
    fi
fi
if hash cbatticon 2>/dev/null; then
    cbatticon &
fi
if hash fcitx 2>/dev/null; then
    fcitx -d
fi
if hash wicd-gtk 2>/dev/null; then
    wicd-gtk -t &
fi

exec awesome
#### end my settings
