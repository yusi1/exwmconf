(require 'aggressive-indent)

(dolist (hook '(emacs-lisp-mode-hook
		lisp-mode-hook
		sh-mode-hook))
  (add-hook hook 'aggressive-indent-mode))

(provide 'aggressive-indent-setup)
