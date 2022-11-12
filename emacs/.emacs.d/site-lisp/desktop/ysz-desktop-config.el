;;; EXWM main configuration (keybinds, workspaces etc..) --- ysz-desktop-config.el

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
	      ;; 's-F': Find-file-at-point
	      ([?\s-F] . find-file-at-point)
	      ;; 's-B': Switch-to-buffer
	      ([?\s-B] . switch-to-buffer)
	      ;; 's-£': Split window right
	      ([?\s-£] . split-window-right)
	      ;; 's-\"': Split window below
	      ([?\s-\"] . split-window-below)
	      ;; 's-\)': Delete window
	      ([?\s-\)] . delete-window)
	      ;; 's-!': Delete other windows
	      ([?\s-!] . delete-other-windows)
	      ;; 's-K': Kill this buffer
	      ([?\s-K] . kill-this-buffer)
	      ;; 's-O': Goto other buffer
	      ([?\s-O] . other-window)

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
	      ([?\s-P] . (lambda () (interactive) (app-launcher-run-app)))
	      ([?\s-b] . (lambda () (interactive) (show-rofi-bookmarks)))
	      ([?\s-t] . eshell)
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
	    ([?\C-\M-d] . [?\M-\S-c])
	    ([?\C-\M-a] . [?\M-\S-r])
	    ([?\C-\M-m] . [?\M-\S-m])
	  )))
  ;; Other configurations
  (exwm-config-misc))

  (ysz-exwm/exwm-config)

  (if (featurep 'xah-fly-keys)
      (use-package ysz-desktop-xah-fly-keys
	:config
	(ysz-exwm/exwm-xah-fly-keys)))
  (if (featurep 'evil)
      (use-package ysz-desktop-evil
	:config
	(ysz-exwm/exwm-evil)))

  ;; Enable EXWM
  (exwm-enable))

(use-package ysz-desktop-window
  :config
  (if (fboundp 'ysz-exwm/exwm-window-config)
      (ysz-exwm/exwm-window-config)))

(provide 'ysz-desktop-config)
;;; ysz-desktop-config.el ends here
