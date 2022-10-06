(require 'all-the-icons-completion)

(all-the-icons-completion-mode t)
(add-hook 'marginalia-mode-hook #'all-the-icons-completion-marginalia-setup)

(provide 'all-the-icons-completion-setup)
