(require 'magit)

(define-key global-map (kbd "C-x g") 'magit-status)
(define-key ctl-x-map (kbd "g") 'magit-status)

(provide 'magit-setup)
