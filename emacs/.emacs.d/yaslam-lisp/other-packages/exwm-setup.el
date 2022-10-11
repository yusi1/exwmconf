;; focus follows mouse
(setq mouse-autoselect-window t)
(setq focus-follows-mouse t)

;; disable things not needed when we have polybar enabled
(display-battery-mode -1)
(display-time-mode -1)

(require 'exwm)
(require 'exwm-config)
(require 'exwm-edit)
;; (require 'exwm-modeline)

;; Set the screen resolution
(require 'exwm-randr)
(exwm-randr-enable)
(start-process-shell-command "autorandr" nil "autorandr -c external-display")

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

;; Start the compositor
(start-process-shell-command "picom" nil "picom -b")

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
		(format "rofi -show combi &"))  )

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
          ([?\C-k] . [S-end delete]))))

;; Ricing tweaks
;; tab bar modeline for after EXWM loads
(prot-tab-status-line 1)
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
  (setq ysz/polybar-process (start-process-shell-command "polybar" nil "polybar my-bar")))

(ysz/start-panel)

;; Enable EXWM
(exwm-enable)

(provide 'exwm-setup)
