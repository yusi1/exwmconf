(require 'deft)

(gkey "<f5>" 'deft)
(gkey "C-x C-n" 'deft-find-file)

(setq deft-extensions '("org" "md" "txt"))
(setq deft-directory "~/Nextcloud/Notes")
(setq deft-recursive t)
(setq deft-auto-save-interval 0)

(provide 'deft-setup)
