;;; UI configurations --- ysz-ui.el

;; (electric-pair-mode 1)
(global-display-line-numbers-mode 1)

(recentf-mode t)
(delete-selection-mode 1)

;; modeline
(column-number-mode 1)

(progn
  (menu-bar-mode -1)
  (tool-bar-mode -1))

(provide 'ysz-ui)
;;; ysz-ui.el ends here
