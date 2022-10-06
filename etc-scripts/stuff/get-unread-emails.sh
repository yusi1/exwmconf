#!/bin/bash

unread=$(notmuch search -- tag:unread and tag:personal and date:today | wc -l | perl -pe 'chomp')
noti="Unread Emails: ${unread}"

while inotifywait -e create ~/mail/personal/new/; do notify-send -i email "$noti"; done
