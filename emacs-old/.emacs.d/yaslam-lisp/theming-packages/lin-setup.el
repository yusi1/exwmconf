(require 'lin)

(defun ysz/lin-mode-enforce-hl-line ()
  (unless hl-line-mode
    (hl-line-mode))
  (lin-mode))

(dolist (hook '(elfeed-search-mode-hook
                notmuch-search-mode-hook
                org-agenda-mode-hook
                magit-mode-hook
                magit-log-mode-hook
                ibuffer-mode-hook
		deft-mode-hook
		bookmark-bmenu-mode-hook))
  (add-hook hook #'ysz/lin-mode-enforce-hl-line)
  ;; (set-face-attribute 'lin-hl nil
  ;;                     :background "#32cd32"
  ;;                     :foreground "#000000")
  (setq lin-face 'lin-blue-override-fg)
  )

(provide 'lin-setup)
