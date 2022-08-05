#!/bin/sh

title=$(xtitle $1)
class=$2
appname=$3

case ${title} in
    # For xfce4-panel settings dialogues
    "Panel Preferences" | "Add New Items" | "Window Buttons")
	echo "state=floating"
	;;
    # Emacs question dialogues
    "Question")
	echo "state=floating"
	;;
esac
