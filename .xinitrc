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

# Launch emacs as a deamon
# cd $HOME; emacs --daemon &

# set the cursor
xsetroot -cursor_name left_ptr

# set keyboard layout
setxkbmap -layout be
setxkbmap -option "caps:escape"

# enable VBox addition (need sudo here at least in current version)
VBoxClient-all &

# emacs daemon
#/usr/bin/emacs --daemon

# set wallpaper
sh ~/.fehbg &

# xmodmap ~/.Xmodmap
# xset b off
exec xmonad
#exec startxfce4
# exec spectrwm
