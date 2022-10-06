(require 'magit)

(keymap-set global-map "C-x g" 'magit-status)
(keymap-set ctl-x-map "g" 'magit-status)

;; To remove conflict with `display-buffer-alist'.
;; https://github.com/magit/magit/issues/4132
(setq magit-display-buffer-same-window-except-diff-v1 t)

;; Inhibit same window in `magit-diff-mode' buffers.
(setq magit-commit-diff-inhibit-same-window t)

(provide 'magit-setup)
