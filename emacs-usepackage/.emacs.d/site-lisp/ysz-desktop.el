;;; Desktop configurations (EXWM et al.) --- ysz-desktop.el

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

(use-package exwm
  :straight t
  :hook ((exwm-init . (lambda ()
			(interactive)
			(ysz-exwm/set-wallpaper)))
	 (exwm-init . (lambda ()
			(interactive)
			(ysz-exwm/start-compositor)))
	 (exwm-init . (lambda ()
			(interactive)
			(ysz-exwm/start-panel)))))

(use-package exwm-config
  :after (exwm))

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

;; (use-package exwm-outer-gaps
;;   :straight '(exwm-outer-gaps :host github
;; 			      :repo "lucasgruss/exwm-outer-gaps")
;;   :after (xelb exwm)
;;   :config
;;   (add-to-list 'exwm-input-global-keys '([?\s-G] . exwm-outer-gaps-mode))
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

(use-package desktop-environment
  :straight t
  :config
  (desktop-environment-mode))

(use-package app-launcher
  :straight '(app-launcher :host github :repo "SebastienWae/app-launcher")
  :demand t
  :bind (("s-P" . (lambda () (interactive) (app-launcher-run-app)))))

(setq mouse-autoselect-window t)
(setq focus-follows-mouse nil)

(defun ysz-exwm/switch-display () (interactive)
       (start-process-shell-command "autorandr" nil "autorandr -c"))

(ysz-exwm/switch-display)

(defun ysz-exwm/set-wallpaper () (interactive)
       (start-process-shell-command "nitrogen" nil "nitrogen --restore"))

(defun ysz-exwm/start-compositor () (interactive)
       (start-process-shell-command "picom" nil "picom -b"))

(defun ysz-exwm/laptop-screen-p ()
  "Check if our current screen is a screen that matches `laptop-preset', then return `t' if so."
  (interactive)
  (let ((displaycmd (shell-command-to-string "sleep 0.5 && autorandr --current | perl -pe 'chomp'"))
	(laptop-preset "mobile")
	(ext-display-preset "external-display"))
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

(ysz-exwm/exwm-config)

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

(provide 'ysz-desktop)
;;; ysz-desktop.el ends here