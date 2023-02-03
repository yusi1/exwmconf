#!/bin/sh

VOLCMD=$(sndioctl | grep output.level | sed 's/output\.level\=//g')
VOL=$(echo "${VOLCMD}*100" | bc)
ADJ="$1"
VOLADJ="$2"

if [[ -z $VOLADJ ]]; then
    UP=3
    DOWN=3
else
    UP=$VOLADJ
    DOWN=$VOLADJ
fi

VOLUP=$(echo "(${VOL}+$UP)/100" | bc -l)
VOLDOWN=$(echo "(${VOL}-$DOWN)/100" | bc -l)

if [[ "$ADJ" == "UP" ]]; then
    sndioctl output.level=+${VOLUP}
fi

if [[ "$ADJ" == "DOWN" ]]; then
    sndioctl output.level=-${VOLDOWN}
fi

if [[ "$ADJ" == "STATUS" ]]; then
    echo "${VOL}"
fi

MUTESTATUS=$(echo "(${VOL}/100)>0" | bc -l)

if [[ "$ADJ" == "TOGMUTE" ]]; then
    if [[ ${MUTESTATUS} -eq 1 ]]; then
        CURVOL=$(echo $(echo "${VOL}/100" | bc -l) > /tmp/curvol)
        sndioctl output.level=0
    fi
    if [[ ${MUTESTATUS} -eq 0 ]]; then
        CURVOL=$(cat /tmp/curvol)
        sndioctl output.level=${CURVOL}
    fi
fi
