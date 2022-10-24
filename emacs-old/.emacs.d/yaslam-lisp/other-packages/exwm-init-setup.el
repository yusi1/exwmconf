(add-hook 'exwm-init-hook (lambda () (interactive)
			    (progn
			      ;; Start the compositor
			      (start-process-shell-command "picom" nil "picom -b")

			      ;; Start nm-applet
			      (start-process-shell-command "nm-applet" nil "nm-applet")

			      ;; Restore the background
			      (start-process-shell-command "nitrogen" nil "nitrogen --restore")

			      ;; Start Polybar
			      (unless (getenv "XDG_CURRENT_DESKTOP")
				(ysz/start-panel)))))

(provide 'exwm-init-setup)
