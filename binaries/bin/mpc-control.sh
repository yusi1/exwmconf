#!/bin/sh
#

PAUSECMD=$(mpc | egrep '(paused|playing)' | awk '{print $1}' | sed 's/\[//g;s/\]//g')
ARG="$1"

case "$ARG" in
    "PAUSE" )
        echo "${PAUSECMD}" > /tmp/mpcpausedstate
        if [[ "$(cat /tmp/mpcpausedstate)" == "paused" ]]; then
            mpc play
        fi
        if [[ "$(cat /tmp/mpcpausedstate)" == "playing" ]]; then
            mpc pause
        fi
        ;;
    "STOP" )
        mpc stop
        ;;
    "NEXT" )
        mpc next
        ;;
    "PREVIOUS" )
        mpc previous
        ;;
esac
