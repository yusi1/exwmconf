;; focus follows mouse
(setq mouse-autoselect-window t)
(setq focus-follows-mouse t)

;; disable things not needed when we have polybar enabled
(display-battery-mode -1)
(display-time-mode -1)

(defun switch-display ()
  (interactive)
  (start-process-shell-command "autorandr" nil "autorandr -c"))

(switch-display)

(require 'exwm)
(require 'exwm-config)
(require 'exwm-edit)
(require 'desktop-environment)
;; (require 'exwm-modeline)

(desktop-environment-mode)

;; Set the screen resolution
(require 'exwm-randr)
(exwm-randr-enable)

(add-hook 'exwm-randr-screen-change-hook (lambda ()
					   (interactive)
					   (switch-display)))

;; (defun exwm-change-screen-hook ()
;;   (let ((xrandr-output-regexp "\n\\([^ ]+\\) connected ")
;;         default-output)
;;     (with-temp-buffer
;;       (call-process "xrandr" nil t nil)
;;       (goto-char (point-min))
;;       (re-search-forward xrandr-output-regexp nil 'noerror)
;;       (setq default-output (match-string 1))
;;       (forward-line)
;;       (if (not (re-search-forward xrandr-output-regexp nil 'noerror))
;;           (call-process "xrandr" nil nil nil "--output" default-output "--auto")
;;         (call-process
;;          "xrandr" nil nil nil
;;          "--output" (match-string 1) "--primary" "--auto"
;;          "--output" default-output "--off")
;;         (setq exwm-randr-workspace-output-plist (list 0 (match-string 1)))))))

;; (add-hook 'exwm-randr-screen-change-hook 'exwm-change-screen-hook)

;; Set the initial workspace number.
(unless (get 'exwm-workspace-number 'saved-value)
  (setq exwm-workspace-number 4))

;; Make class name the buffer name
(add-hook 'exwm-update-class-hook
          (lambda ()
            (exwm-workspace-rename-buffer exwm-class-name)))

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

(defun exwm-simple-lock ()
  (interactive)
  (call-process shell-file-name nil nil nil
		shell-command-switch
		(format "slock &")))

;; Global keybindings.
(unless (get 'exwm-input-global-keys 'saved-value)
  (setq exwm-input-global-keys
        `(
          ;; 's-r': Reset (to line-mode).
          ([?\s-r] . exwm-reset)

	  ;; Move between windows
	  ([s-left] . windmove-left)
	  ([s-right] . windmove-right)
	  ([s-up] . windmove-up)
	  ([s-down] . windmove-down)
	  
          ;; 's-w': Switch workspace.
          ([?\s-w] . exwm-workspace-switch)
	  
          ;; 's-&': Launch application.
          ([?\s-&] . (lambda (command)
                       (interactive (list (read-shell-command "$ ")))
                       (start-process-shell-command command nil command)))
	  ;; 's-p': Launch rofi
	  ([?\s-p] . show-rofi)
	  ;; 's-b': Launch rofi-bookmarks
	  ([?\s-b] . show-rofi-bookmarks)
	  ;; 's-P': Launch Emacs app-launcher
	  ([?\s-P] . (lambda () (interactive)
		       (app-launcher-run-app)))

	  ;; 's-\`'': Switch to workspace 0 with the grave key.
	  ([?\s-`] . (lambda () (interactive)
		       (exwm-workspace-switch-create 0)))
	  
          ;; 's-N': Switch to certain workspace.
          ,@(mapcar (lambda (i)
                      `(,(kbd (format "s-%d" i)) .
                        (lambda ()
                          (interactive)
                          (exwm-workspace-switch-create ,i))))
                    (number-sequence 0 9))
	  
	  ;; 's-l': Lock the screen
	  ([?\s-l] . exwm-simple-lock))))

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
	  ([M-delete] . [C-delete]))))

;; Ricing tweaks
;; tab bar modeline for after EXWM loads
;; (prot-tab-status-line 1)
;;floating window border
(setq exwm-floating-border-width 2)
;;exwm modeline mode (show workspaces in modeline)
;; (exwm-modeline-mode 1)

;; Free up space
(defun exwm-config-misc ()
  "Other configurations."
  ;; Make more room
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (scroll-bar-mode -1))

(exwm-config-misc)

;; logout when in LXQT
(defun exwm-logout ()
  (interactive)
  (recentf-save-list)
  (save-some-buffers)
  (start-process-shell-command "logout" nil "lxqt-leave"))

;; Window control rules
(add-list-to-list 'display-buffer-alist '(("pavucontrol"
					   (display-buffer-in-side-window)
					   (side . bottom)
					   (window-height . 10))))

;; EXWM per-application window behaviour rules
;; (setq exwm-manage-configurations nil)
;;; Example (check the docstring of variable `exwm-manage-configurations')
;; (setq exwm-manage-configurations '(((string-match-p "Featherpad" exwm-class-name)
;;                                     floating t))))

(setq exwm-manage-configurations '(
				   ;; Spectacle (screenshot application)
				   ((string-match-p "spectacle" exwm-class-name)
				    floating-mode-line nil)
				   
				   ))

(defun ysz/exwm--format-window-title-firefox (title &optional length)
  "Removes noise from and trims Firefox window titles.
Assumes the Add URL to Window Title extension is enabled and
configured to use @ (at symbol) as separator."
  (let* ((length (or length 55))
         (title (concat "F# " (replace-regexp-in-string " [-—] Mozilla Firefox$" "" title)))
         (title-and-hostname (split-string title "@" nil " "))
         (hostname (substring (car (last title-and-hostname)) 0 -1))
         (page-title (string-join (reverse (nthcdr 1 (reverse title-and-hostname))) " "))
         (short-title (reverse (string-truncate-left (reverse page-title) length))))
    (if (length> title-and-hostname 1)
        (concat short-title " @ " hostname)
      (reverse (string-truncate-left (reverse title) length)))))

(defun ysz/exwm--format-window-title-librewolf-default (title &optional length)
  "Removes noise from and trims LibreWolf window titles.
Assumes the Add URL to Window Title extension is enabled and
configured to use @ (at symbol) as separator."
  (let* ((length (or length 55))
         (title (concat "L# " (replace-regexp-in-string " [-—] LibreWolf$" "" title)))
         (title-and-hostname (split-string title "@" nil " "))
         (hostname (substring (car (last title-and-hostname)) 0 -1))
         (page-title (string-join (reverse (nthcdr 1 (reverse title-and-hostname))) " "))
         (short-title (reverse (string-truncate-left (reverse page-title) length))))
    (if (length> title-and-hostname 1)
        (concat short-title " @ " hostname)
      (reverse (string-truncate-left (reverse title) length)))))

(defun ysz/exwm--format-window-title-* (title)
  "Removes annoying notifications counters."
  (string-trim (replace-regexp-in-string "([[:digit:]]+)" "" title)))

(defun ysz/exwm-buffer-name ()
  "Guesses (and formats) the buffer name using the class of the X client."
  (let ((title (ysz/exwm--format-window-title-* exwm-title))
        (formatter (intern
                    (format "ysz/exwm--format-window-title-%s"
			    (downcase exwm-class-name)))))
    (if (fboundp formatter)
        (funcall formatter title)
      title)))

(add-hook 'exwm-update-title-hook
	  (lambda ()
	    (progn
	      (exwm-workspace-rename-buffer
	       (ysz/exwm-buffer-name)))))

;; (PREDICATE FUNCTION)
;; get current screen preset using `autorandr' and return `t' if we are on the laptop display
(defun ysz/laptop-screen-p ()
  (interactive)
  (let ((displaycmd (shell-command-to-string "sleep 0.5 && autorandr --current | perl -pe 'chomp'"))
	(laptop-preset "mobile")
	(ext-display-preset "external-display"))
    (string-match-p displaycmd laptop-preset)))

;; polybar functions
(defvar ysz/polybar-process nil
  "Holds the process of the running Polybar instance, if any")

(defun ysz/kill-panel ()
  (interactive)
  (when ysz/polybar-process
    (ignore-errors
      (kill-process ysz/polybar-process)))
  (setq ysz/polybar-process nil))

(defun ysz/start-panel ()
  (interactive)
  (ysz/kill-panel)
  (if (ysz/laptop-screen-p)
      (setq ysz/polybar-process (start-process-shell-command "polybar" nil "polybar --config=~/.config/polybar/config-smallscreen.ini"))
    (setq ysz/polybar-process (start-process-shell-command "polybar" nil "polybar --config=~/.config/polybar/config.ini"))))

;; refresh panel on screen change event
(add-hook 'exwm-randr-screen-change-hook (lambda ()
					   (interactive)
					   (ysz/start-panel)))

;; refresh wallpaper on screen change event
(add-hook 'exwm-randr-screen-change-hook (lambda ()
					   (interactive)
					   (start-process-shell-command "nitrogen" nil "nitrogen --restore")))

;;save fontaine preset before EXWM exits
(add-hook 'exwm-exit-hook #'fontaine-store-latest-preset)

;;save cursory preset before EXWM exits
(add-hook 'exwm-exit-hook #'cursory-store-latest-preset)

;; Enable EXWM
(exwm-enable)

(provide 'exwm-setup)
