;;; Desktop configurations (EXWM et al.) --- ysz-desktop.el

(use-package xelb
  :straight '(xelb :type git :host github :repo "ch11ng/xelb"))
;;;;;;;;;;;
(use-package exwm
  :after (xelb)
  :straight '(exwm :type git :host github :repo "ch11ng/exwm")
  :preface
  (setq x-no-window-manager t) ;; fix point focus bug (GH ISSUE #889)
  (setq mouse-autoselect-window t)
  (setq focus-follows-mouse nil)
  (display-battery-mode 1)
  (display-time-mode 1)
  :hook ((exwm-init . (lambda ()
			(interactive)
			(ysz-exwm/set-wallpaper)))
	 (exwm-init . (lambda ()
			(interactive)
			(ysz-exwm/start-compositor)))
	 ;; (exwm-init . (lambda ()
	 ;; 		(interactive)
	 ;; 		(ysz-exwm/start-panel)))
	 (exwm-init . (lambda ()
			(interactive)
			(ysz-exwm/start-xsettingsd)))))

(use-package exwm-randr
  :after (exwm)
  :hook ((exwm-randr-screen-change . (lambda ()
				       (interactive)
				       (ysz-exwm/switch-display)))
	 (exwm-randr-screen-change . (lambda ()
				       (interactive)
				       (ysz-exwm/set-wallpaper)))
	 ;; (exwm-randr-screen-change . (lambda ()
	 ;; 			       (interactive)
	 ;; 			       (ysz-exwm/start-panel)))
	 )
  :config
  (exwm-randr-enable))

;;; Main configs
(use-package ysz-desktop-config
  :after (exwm))

;;; Misc configs
(use-package ysz-desktop-misc
  :after (exwm))

(provide 'ysz-desktop)
;;; ysz-desktop.el ends here
