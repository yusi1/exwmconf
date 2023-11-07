;;; Language helpers (e.g: paredit, etc..) --- ysz-lang-helpers.el

(use-package parinfer-rust-mode
  :straight t
  :hook emacs-lisp-mode
  :config
  (setq-default indent-tabs-mode nil) ;; disable tabs
  (setq parinfer-rust-auto-download t))

(provide 'ysz-lang-helpers)
;;; ysz-lang-helpers.el ends here
