#!/bin/sh

VOLUME="$(sndiovolv2.sh STATUS | xargs printf %.0f)"

echo ${VOLUME} | dbar -max 100 -min 0 -s '#' -l 'Vol'
