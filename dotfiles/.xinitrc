#!/bin/sh

if [ -f ~/.Xresources ];then
    xrdb -merge -I$HOME ~/.Xresources
fi

exec /usr/bin/i3
