#!/usr/local/bin/bash

VOL_CMD=$(sndioctl output.level | cut -d'=' -f2)
ARG[1]=$1
if [ ! -z $2 ]; then
    ARG[2]=$(bc -l <<< "$2/100" | xargs printf %.2f)
fi

case ${ARG[1]} in
    "STATUS")
        bc -l <<< "${VOL_CMD}*100";;
    "UP")
        sndioctl output.level=+${ARG[2]};;
    "DOWN")
        sndioctl output.level=-${ARG[2]};;
    "TOGMUTE")
        sndioctl output.mute=!
        notify-send "Volume Muted";;
esac
