#!/bin/sh
#

pamixer --get-volume > /tmp/vol
prev_sha="$(shasum /tmp/vol > /tmp/sha)"

while true; do
    pamixer --get-volume > /tmp/vol
    cur_sha="$(shasum /tmp/vol > /tmp/sha)"
    if [[ "${cur_sha}" != "${prev_sha}" ]]; then
       prev_sha="${cur_sha}" 
       continue
    fi
done
