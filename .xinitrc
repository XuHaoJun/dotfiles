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
export BROWSER=firefox #or any brower of your choice

# #Loacle
#export LANG=zh_TW.Big5
#export LANG=zh_TW.utf8
export LC_CTYPE=zh_TW.Big5
export MM_CHARSET=big5 

# export LANG=zh_CN.UTF-8
# export LC_ALL="zh_TW.zh_CN.UTF-8"

#IBUS
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
export GTK_MODULE=ibus
export QT_MODULE=ibus
export G_FILENAME_ENCODING=@utf8
export XIM_PROGRAM="ibus-daemon -d -x"
export LC_CTYPE="zh_TW.utf8"
ibus-daemon -d -x


if [ -f $HOME/.Xmodmap ]; then
    /usr/bin/xmodmap $HOME/.Xmodmap
fi

if [ -f $HOME/.Xresources ]; then
    /usr/bin/xrdb $HOME/.Xresources
fi

if [ -f $HOME/.xbindkeysrc ]; then
    /usr/bin/xbindkeys -f $HOME/.xbindkeysrc
fi

# exec gnome-session
# exec startkde
# exec startxfce4
# ...or the Window Manager of your choice

# custom
#exec ck-launch-session dbus-launch -exit-with-session awesome
exec ck-launch-session dbus-launch awesome
#exec awesome
#### end my settings
