#!/usr/bin/env bash

SIXTYHZ=$(xrandr | grep " connected" -A1 | grep "60.*\*")
FOURTYFOURHZ=$(xrandr | grep " connected" -A1 | grep "144.*\*")
