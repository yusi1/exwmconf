(require 'marginalia)

(define-key global-map (kbd "M-A") 'marginalia-cycle)

(marginalia-mode t)

(provide 'marginalia-setup)
