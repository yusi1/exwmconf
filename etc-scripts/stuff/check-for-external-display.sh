#!/bin/bash

int_display="eDP1"
ext_display="HDMI1"
check=$(xrandr -q | grep "$ext_display connected")

if [[ ${check} ]]; then
    xrandr --output $ext_display --primary --mode 1920x1080 --rate 60 
    xrandr --output $int_display --off
else
    xrandr --output $int_display --primary --mode 1366x768 --rate 60
fi
