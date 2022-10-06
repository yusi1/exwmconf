(require 'electric-cursor)

(setq electric-cursor-alist '((eshell-mode . (hbar . 4))
			      (shell-mode . (hbar . 4))
			      (vterm-mode . (hbar . 4))
			      (t . box)))

(electric-cursor-mode t)

(provide 'electric-cursor-setup)
