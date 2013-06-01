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

#IBUS
export GTK_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export QT_IM_MODULE=fcitx
export GTK_MODULE=fcitx
export QT_MODULE=fcitx
export G_FILENAME_ENCODING=@utf8
#export XIM_PROGRAM="fcitxn"
export LC_CTYPE="zh_TW.utf8"


if [ -f $HOME/.Xmodmap ]; then
    /usr/bin/xmodmap $HOME/.Xmodmap
fi

if [ -f $HOME/.Xresources ]; then
    /usr/bin/xrdb $HOME/.Xresources
fi

if [ -f $HOME/.xbindkeysrc ]; then
    /usr/bin/xbindkeys -f $HOME/.xbindkeysrc
fi

# screen powersave
xset +dpms
xset dpms 0 0 300


# exec gnome-session
# exec startkde
# exec startxfce4
# ...or the Window Manager of your choice

# custom
#exec ck-launch-session dbus-launch -exit-with-session awesome
#exec ck-launch-session dbus-launch awesome
#trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 6 --transparent true --alpha 0 --tint 0x000000 --height 16 &
#wicd-client --tray &
#batti &
#emacs &
urxvtd &
(sleep 5 && dropboxd) &
xscreensaver -no-splash &
loliclip --daemon &
fcitx &
xsetroot -cursor_name left_ptr

exec ~/.monsterwm.d/dzconky.sh
#### end my settings
