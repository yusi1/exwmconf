#!/bin/bash
# Start activitywatcher

cd ~/.local/opt/activitywatch

pkill aw-

yszKillAwServer=$(pgrep aw -a | grep "server" | awk '{print $1}')
yszKillWindowWatcher=$(pgrep aw -a | grep "window" | awk '{print $1}')
yszKillAfkWatcher=$(pgrep aw -a | grep "afk" | awk '{print $1}')

aw-server &
aw-watcher-utilization &

if [[ "$XDG_CURRENT_DESKTOP" == "GNOME" ]]
then
    ${yszKillWindowWatcher}
    ${yszKillAfkWatcher}
    aw-watcher-gnome &
    if [[ "$XDG_SESSION_TYPE" != "wayland" ]]
    then
        [[ $(pgrep aw-server) ]] && aw-watcher-afk &
        [[ $(pgrep aw-server) ]] && aw-watcher-window &
    fi
fi

if [[ "$XDG_SESSION_TYPE" == "wayland" && "$XDG_CURRENT_DESKTOP" != "GNOME" ]]
then
    ${yszKillWindowWatcher}
    ${yszKillAfkWatcher}
    aw-watcher-wayland &
else
    [[ $(pgrep aw-server) ]] && aw-watcher-afk &
    [[ $(pgrep aw-server) ]] && aw-watcher-window &
fi

notify-send "ActivityWatch started"
