#!/bin/bash

command=$(pactl list | grep --quiet "State: RUNNING")

if ${command}; then
    echo "Audio detected.."
else
    echo "Audio not detected.."
fi
