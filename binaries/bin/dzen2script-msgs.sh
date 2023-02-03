#!/bin/sh

while true; do
    LOG="$(cat /var/log/messages | tail -n20 | sort -r)"
    echo "${LOG}" | perl -ne 'print "^fg(black) $_"'
    echo "^fg(lime)"
    sleep 20
done | dzen2 -u -ta left -bg aqua -x 580 -w 800 -l 20
