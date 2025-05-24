#!/usr/bin/env sh

if pgrep -x "hypridle" >/dev/null ;then
    killall hypridle
    notify-send Hypridle Off
else
    hypridle &
    notify-send Hypridle On
fi
