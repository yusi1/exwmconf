;;; Init Functions for EXWM --- ysz-desktop-init.el

(defun ysz-exwm/switch-display () (interactive)
       (start-process-shell-command "autorandr" nil "autorandr -c"))

(defun ysz-exwm/set-wallpaper () (interactive)
       (start-process-shell-command "nitrogen" nil "nitrogen --restore"))

(defun ysz-exwm/start-compositor () (interactive)
       (start-process-shell-command "picom" nil "picom -b"))

(defun ysz-exwm/laptop-screen-p ()
  "Check if our current screen is a screen that matches `laptop-preset', then return `t' if so."
  (let ((displaycmd (shell-command-to-string "sleep 0.5 && autorandr --current | perl -pe 'chomp'"))
	(laptop-preset "mobile")
	(ext-display-preset "docked"))
    (string-match-p displaycmd laptop-preset)))

(defvar ysz-exwm/polybar-process nil
  "Holds the process of the running Polybar instance, if any")

(defun ysz-exwm/kill-panel ()
  (interactive)
  (when ysz-exwm/polybar-process
    (ignore-errors
      (kill-process ysz-exwm/polybar-process)))
  (setq ysz-exwm/polybar-process nil))

(defun ysz-exwm/start-panel ()
  (interactive)
  (ysz-exwm/kill-panel)
  (if (ysz-exwm/laptop-screen-p)
      (setq ysz-exwm/polybar-process (start-process-shell-command "polybar" nil "polybar --config=~/.config/polybar/config-smallscreen.ini"))
    (setq ysz-exwm/polybar-process (start-process-shell-command "polybar" nil "polybar --config=~/.config/polybar/config.ini"))))

(defvar ysz-exwm/xsettingsd-process nil
  "Holds the process of the running Xsettingsd instance, if any")

(defun ysz-exwm/kill-xsettingsd ()
  (interactive)
  (when ysz-exwm/xsettingsd-process
    (ignore-errors
      (kill-process ysz-exwm/xsettingsd-process)))
  (setq ysz-exwm/xsettingsd-process nil))

(defun ysz-exwm/start-xsettingsd ()
  (interactive)
  (ysz-exwm/kill-xsettingsd)
  (setq ysz-exwm/xsettingsd-process
	(start-process-shell-command "xsettingsd" nil "xsettingsd")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;

(ysz-exwm/switch-display)

(provide 'ysz-desktop-init)
;;; ysz-desktop-init.el ends here
