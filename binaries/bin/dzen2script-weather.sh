#!/bin/sh

while true; do
    if [ ! -f /tmp/weather ]; then
        WEATHER="$(curl wttr.in/Turriff?0T | head -n8 > /tmp/weather)"
    fi
    if [ -f /tmp/weather ]; then
        cat /tmp/weather && sleep 2
        rm /tmp/weather
        echo -e "\n\n\n\n\n\n\n" >> /tmp/weather
    fi
done| dzen2 -u -l 8 -ta left -y 20 -fn "DejaVu Sans Mono:size=18:style=Bold" -w 300
