;;; Xah-Fly-Keys integrations for EXWM --- ysz-desktop-xah-fly-keys.el

(defun ysz-exwm/exwm-xah-fly-keys ()
  "Xah-Fly-Keys integrations for EXWM."
  (add-hook 'exwm-mode-hook 'xah-fly-mode-toggle)
  (add-to-list 'exwm-input-global-keys
	       `([?\s-q] . xah-fly-mode-toggle)))

(provide 'ysz-desktop-xah-fly-keys)
;;; ysz-desktop-xah-fly-keys.el ends here
