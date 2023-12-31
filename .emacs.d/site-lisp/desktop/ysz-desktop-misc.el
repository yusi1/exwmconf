;;; Misc packages and functions for the DE experience --- ysz-desktop-misc.el

;;; EXWM-related integration packages

;; (use-package exwm-outer-gaps
;;   :straight '(exwm-outer-gaps :host github
;; 			      :repo "lucasgruss/exwm-outer-gaps")
;;   :init
;;   (setq exwm-outer-gaps-width [3 3 3 3])
;;   (add-hook 'exwm-init-hook (lambda () (interactive) (exwm-outer-gaps-mode 1))))

(use-package exwm-edit
  :straight t
  :demand t
  :bind (("C-c '" . exwm-edit--compose)
	 ("C-c C-'" . exwm-edit--compose))
  :config
  (defun ysz-exwm/on-exwm-edit-compose ()
      (funcall 'markdown-mode))
  (add-hook 'exwm-edit-compose-hook 'ysz-exwm/on-exwm-edit-compose))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package desktop-environment
  :straight t
  :config
  ;; (setq desktop-environment-volume-get-command "pamixer --get-volume-human")
  ;; (setq desktop-environment-volume-set-command "pamixer --set-volume %s")
  ;; (setq desktop-environment-volume-normal-increment "2")
  
  (desktop-environment-mode))

(use-package app-launcher
  :straight '(app-launcher :host github :repo "SebastienWae/app-launcher")
  :demand t
  :bind (("s-P" . (lambda () (interactive) (app-launcher-run-app)))))

(use-package engine-mode
  :straight t
  :config
  (engine/set-keymap-prefix (kbd "C-x /"))
  (setq browse-url-firefox-new-window-is-tab nil)
  (setq browse-url-firefox-arguments '("--new-window"))
  (setq engine/browser-function 'browse-url-firefox)
  ;;;;;;;;;;;;;;;;;;;;
  (defengine youtube
    "https://youtube.com/results?search_query=%s"
    :keybinding "y")
  (defengine hnalgolia
    "https://hn.algolia.com/?dateRange=all&page=0&prefix=true&query=%s&sort=byPopularity&type=story"
    :keybinding "h")
  (defengine github
    "https://github.com/search?q=%s"
    :keybinding "g")
  (defengine brave
    "https://search.brave.com/search?q=%s"
    :keybinding "b")
  (defengine neeva
    "https://neeva.com/search?q=%s"
    :keybinding "n")
  (defengine url
    "%s"
    :keybinding "u")

  (engine-mode t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun show-rofi ()
  (interactive)
  (call-process shell-file-name nil nil nil
		shell-command-switch
		(format "rofi -show drun &"))  )

(defun show-rofi-bookmarks ()
  (interactive)
  (call-process shell-file-name nil nil nil
		shell-command-switch
		(format "rofi -show bookmarks -modi \"bookmarks: rofi-bookmarks.py\"")))

(provide 'ysz-desktop-misc)
;;; ysz-desktop-misc.el ends here
