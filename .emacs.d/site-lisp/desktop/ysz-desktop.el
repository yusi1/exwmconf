;;; Desktop configurations (EXWM et al.) --- ysz-desktop.el

;; (use-package xelb
;;   :straight t)
;; ;;;;;;;;;;;
;; (use-package exwm
;;   :after (xelb)
;;   :straight t
;;   :preface
;;   (setq x-no-window-manager t) ;; fix point focus bug (GH ISSUE #889)
;;   (setq mouse-autoselect-window t)
;;   (setq focus-follows-mouse nil)
;;   (display-battery-mode 1)
;;   (display-time-mode 1)
;;   ;;transparency
;;   (set-frame-parameter (selected-frame) 'alpha-background 85)
;;   (add-to-list 'default-frame-alist '(alpha-background . 85))
;;   :hook ((exwm-init . (lambda ()
;; 			(interactive)
;; 			(ysz-exwm/set-wallpaper)))
;; 	 (exwm-init . (lambda ()
;; 			(interactive)
;; 			(ysz-exwm/start-compositor)))
;; 	 (exwm-init . (lambda ()
;; 			(interactive)
;; 			(ysz-exwm/start-xsettingsd)))
;; 	 (exwm-init . (lambda ()
;; 			(interactive)
;; 			(start-process-shell-command "dex" nil
;; 						     "dex ~/.config/autostart/*.desktop")))))

(use-package exwm-randr
  :config
  (exwm-randr-enable))

;;; Main configs
(use-package ysz-desktop-config)

;;; Misc configs
(use-package ysz-desktop-misc)

(provide 'ysz-desktop)
;;; ysz-desktop.el ends here
