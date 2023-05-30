export PATH="$HOME/.cabal/bin:$HOME/.local/bin:$HOME/.config/emacs/bin:$PATH"
setxkbmap gb
xrdb -merge ~/.Xresources
sleep 1 && xeyes &
xterm &
exec dbus-run-session -- ~/.cache/xmonad/xmonad-x86_64-linux
