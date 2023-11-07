;;; Desktop configurations (EXWM et al.) --- ysz-desktop.el

(use-package xelb
  :straight '(xelb :type git :host github :repo "ch11ng/xelb"))
;;;;;;;;;;;
(use-package exwm
  :after (xelb)
  :straight '(exwm :type git :host github :repo "ch11ng/exwm")
  :hook ((exwm-init . (lambda ()
			(interactive)
			(ysz-exwm/set-wallpaper)))
	 (exwm-init . (lambda ()
			(interactive)
			(ysz-exwm/start-compositor)))
	 (exwm-init . (lambda ()
			(interactive)
			(ysz-exwm/start-panel)))
	 (exwm-init . (lambda ()
			(interactive)
			(ysz-exwm/start-xsettingsd)))))

(use-package exwm-config
  :after (exwm)
  :config
  (defun ysz-exwm/exwm-config ()
    "My configuration of EXWM."
    ;; Set the initial workspace number.
    (unless (get 'exwm-workspace-number 'saved-value)
      (setq exwm-workspace-number 4))
    ;; Make class name the buffer name
    (add-hook 'exwm-update-class-hook
              (lambda ()
		(exwm-workspace-rename-buffer exwm-class-name)))
    ;; Global keybindings.
    (unless (get 'exwm-input-global-keys 'saved-value)
      (setq exwm-input-global-keys
            `(
              ;; 's-r': Reset (to line-mode).
              ([?\s-r] . exwm-reset)
              ;; 's-w': Switch workspace.
              ([?\s-w] . exwm-workspace-switch)
              ;; 's-&': Launch application.
              ([?\s-&] . (lambda (command)
                           (interactive (list (read-shell-command "$ ")))
                           (start-process-shell-command command nil command)))

            ;; 's-N': Switch to certain workspace.
            ,@(mapcar (lambda (i)
                        `(,(kbd (format "s-%d" i)) .
                          (lambda ()
                            (interactive)
                            (exwm-workspace-switch-create ,i))))
                      (number-sequence 0 9))
	    ([?\s-`] . (lambda () (interactive) (exwm-workspace-switch 0)))
	    ([?\s-p] . (lambda () (interactive) (show-rofi)))
	    ([?\s-b] . (lambda () (interactive) (show-rofi-bookmarks)))
	    )))
  ;; Line-editing shortcuts
  (unless (get 'exwm-input-simulation-keys 'saved-value)
    (setq exwm-input-simulation-keys
          '(([?\C-b] . [left])
            ([?\C-f] . [right])
            ([?\C-p] . [up])
            ([?\C-n] . [down])
            ([?\C-a] . [home])
            ([?\C-e] . [end])
            ([?\M-v] . [prior])
            ([?\C-v] . [next])
            ([?\C-d] . [delete])
            ([?\C-k] . [S-end delete])
	    ([?\C-/] . [?\C-z])
	    ([?\M-f] . [C-right])
	    ([?\M-b] . [C-left])
	    ([?\M-d] . [C-S-right delete])
	    ;; FIXME:: Figure out a way to bind Alt+Backspace to Control+Delete
	    ;; (() . [C-delete])
	  )))
  ;; Enable EXWM
  (exwm-enable)
  ;; Other configurations
  (exwm-config-misc))
  
  (ysz-exwm/exwm-config))

(use-package exwm-randr
  :after (exwm)
  :hook ((exwm-randr-screen-change . (lambda ()
				       (interactive)
				       (ysz-exwm/switch-display)))
	 (exwm-randr-screen-change . (lambda ()
				       (interactive)
				       (ysz-exwm/set-wallpaper)))
	 (exwm-randr-screen-change . (lambda ()
				       (interactive)
				       (ysz-exwm/start-panel))))
  :config
  (exwm-randr-enable))

(use-package desktop-environment
  :straight t
  :config
  (desktop-environment-mode))

(use-package app-launcher
  :straight '(app-launcher :host github :repo "SebastienWae/app-launcher")
  :demand t
  :bind (("s-P" . (lambda () (interactive) (app-launcher-run-app)))))

(use-package engine-mode
  :straight t
  :config
  (engine/set-keymap-prefix (kbd "C-j"))
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
  (defengine url
    "%s"
    :keybinding "u")

  (engine-mode t))


(defun ysz-exwm/fmat-wintitle-firefox (title &optional length)
  "Removes noise from and trims Firefox window titles."
  (let* ((length (or length 55))
         (title (concat "F# " (replace-regexp-in-string " [-—] Mozilla Firefox$" "" title))))
    (reverse (string-truncate-left (reverse title) length))))

(defun ysz-exwm/buffer-name ()
  "Guesses (and formats) the buffer name using the class of the X client."
  (let ((title exwm-title)
	(formatter (intern
                    (format "ysz-exwm/fmat-wintitle-%s"
			    (downcase exwm-class-name)))))
    (if (fboundp formatter)
        (funcall formatter title)
      title)))

(add-hook 'exwm-update-title-hook (lambda ()
				    (progn
				      (exwm-workspace-rename-buffer
				       (ysz-exwm/buffer-name)))))

(add-list-to-list 'display-buffer-alist '(("pavucontrol"
					   (display-buffer-in-side-window)
					   (side . bottom)
					   (window-height . 10))))

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

(provide 'ysz-desktop)
;;; ysz-desktop.el ends here
