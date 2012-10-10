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

# screen powersave
xset +dpms
xset dpms 0 0 300

#Thinkpad trackpoint middle button emulation
xinput list | sed -ne 's/^[^ ][^V].*id=\([0-9]*\).*/\1/p' | while read id
do
    case `xinput list-props $id` in
        *"Middle Button Emulation"*)
            xinput set-int-prop $id "Evdev Wheel Emulation" 8 1
            xinput set-int-prop $id "Evdev Wheel Emulation Button" 8 2
            xinput set-int-prop $id "Evdev Wheel Emulation Timeout" 8 200
            xinput set-int-prop $id "Evdev Wheel Emulation Axes" 8 6 7 4 5
            xinput set-int-prop $id "Evdev Middle Button Emulation" 8 0
            ;;
    esac
done

# exec gnome-session
# exec startkde
# exec startxfce4
# ...or the Window Manager of your choice

# custom
#exec ck-launch-session dbus-launch -exit-with-session awesome
#exec ck-launch-session dbus-launch awesome
exec awesome
#### end my settings
