#!/bin/sh
pacman -Sl custom | sed 's/\[installed\]//g;s/custom\ //g' | aur vercmp
