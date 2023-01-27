#!/bin/sh

pkill conky && conky -c ~/.config/conky/conky-moregap.conf && conky -c ~/.config/conky/conky-mpd.conf
nitrogen --restore

pkill stalonetray
/usr/bin/stalonetray
