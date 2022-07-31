;; -*-lisp-*-

(in-package :stumpwm)

(run-shell-command "libinput-gestures")
(sleep 0.5)
; (run-shell-command "barrier")
; (sleep 0.5)
(run-shell-command "/bin/bash -c ~/stuff/check-for-external-display.sh")
 
;; Autostart these applications
;; (run-shell-command "picom -b")
(sleep 0.5)
(run-shell-command "/bin/bash -c ~/.fehbg")
(sleep 0.5)
(run-shell-command "xfce4-power-manager")
(sleep 0.5)
(run-shell-command "/bin/bash -c ~/stuff/volumed.sh")
(sleep 0.5)
(run-shell-command "/usr/lib/x86_64-linux-gnu/polkit-mate/polkit-mate-authentication-agent-1")
(sleep 0.5)
(run-shell-command "nextcloud --background")
(sleep 0.5)
(run-shell-command "/usr/local/bin/compton")
;;(run-shell-command "/bin/bash -c ~/stuff/start-volumed.sh")
;;(sleep 0.5)
;; (run-shell-command "gnome-terminal -- tmux new-session")
;;(sleep 0.5)
;;(run-shell-command "emacs")

;; (gnew "Torrents")
;; (sleep 1)
;; (run-shell-command "qbittorrent")
;; (sleep 2)

;; (gnew "Music")
;; (sleep 0.5)
;; (run-shell-command "pavucontrol")
;; (sleep 0.5)
;; (run-shell-command "mpd")
;; (sleep 2)
;; (run-shell-command "cantata")

;; Finally, start the mode-line
(sleep 0.5)
(mode-line)

;; Start the system tray aswell
;; (load-module "stumptray")
;; (stumptray:stumptray)
