(require 'diff-hl)

(add-hook 'magit-pre-refresh-hook 'diff-hl-magit-pre-refresh)
(add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)

;; (setq diff-hl-margin-mode t)
(add-hook 'dired-mode-hook 'diff-hl-dired-mode)

(global-diff-hl-mode)

(provide 'diff-hl-setup)
