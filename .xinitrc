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

# set the cursor
xsetroot -cursor_name left_ptr

# set keyboard layout
setxkbmap -layout be

# enable VBox addition (need sudo here at least in current version)
sudo VBoxClient-all &

# xmodmap ~/.Xmodmap
# xset b off
exec xmonad
# exec gnome-session
