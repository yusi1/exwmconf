#!/bin/sh

while true; do
    VOL="$(sndiovol.sh STATUS)"       
    VOLNODECIMALS="$(printf %.0f ${VOL})"
    if [[ "${VOLNODECIMALS}" < 98 ]]; then
        sndiovol.sh UP 1
    else
        sndiovol.sh DOWN 99
        continue
    fi
    # if [[ "${VOLNODECIMALS}" == 98 ]]; then
    #     sndiovol.sh DOWN 1
    # fi
done

