#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
BROWSER=/usr/bin/chromium
# BROWSER=/usr/bin/epiphany
EDITOR=/usr/bin/nano
HTTP_PROXY="http://localhost:8118"

if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ];
then
  # way-cooler
  # sway
  weston-launch
fi

# if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]] && [[ -z $XDG_SESSION_TYPE ]]; then
#   XDG_SESSION_TYPE=wayland exec dbus-run-session gnome-session
# fi

# udisksctl mount -b /dev/disk/by-label/dapper-data
# mount /media/dapper-data
