;; -*-lisp-*-

(in-package :stumpwm)

;; (run-shell-command "libinput-gestures")
;; (run-shell-command "barrier")
;; (sleep 0.5)
(run-shell-command "/bin/bash -c ~/stuff/check-for-external-display.sh")
 
(sleep 0.5)
(run-shell-command "xsetroot -cursor_name left_ptr")
(sleep 0.5)
(run-shell-command "xsettingsd")
(sleep 0.5)
(run-shell-command "dunst")
(sleep 0.5)
(run-shell-command "udiskie")

;;;(run-shell-command "picom -b")
;(sleep 0.5)
;(run-shell-command "nitrogen --restore")
;(sleep 0.5)
;(run-shell-command "xfce4-notifyd-start")
;(sleep 0.5)
;(run-shell-command "xfce4-power-manager")
;(sleep 0.5)
;;; (run-shell-command "/bin/bash -c ~/stuff/start-volumed.sh")
;(run-shell-command "start-pulseaudio-x11")
;(sleep 2.0)
;(run-shell-command "volumeicon")
;(sleep 0.5)
;(run-shell-command "/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1")
;(sleep 0.5)
;(run-shell-command "kdeconnect-indicator")
;;; (sleep 0.5)
;;; (run-shell-command "nextcloud --background")

;; Finally, start the mode-line
; (sleep 0.5)
; (mode-line)

;; Start the system tray aswell
;; (load-module "stumptray")
;; (stumptray:stumptray)
