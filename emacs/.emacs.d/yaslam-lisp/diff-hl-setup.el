(require 'diff-hl)

(global-diff-hl-mode)
(add-hook 'magit-pre-refresh-hook 'diff-hl-magit-pre-refresh)
(add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)

(setq diff-hl-margin-mode t)
(setq diff-hl-dired-mode t)

(provide 'diff-hl-setup)
