;;; Configurations for extra language packages --- ysz-lang.el

(use-package markdown-mode
  :straight t)

(use-package haskell-mode
  :straight t)

(use-package ahk-mode
  :straight t)

(use-package sly
  :straight t)

(use-package scss-mode
  :straight '(:type git :host github :repo "antonj/scss-mode")
  :config
  (setq scss-compile-at-save t)
  (add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))
  (add-to-list 'auto-mode-alist '("\\.sass\\'" . scss-mode)))

(add-to-list 'auto-mode-alist '("\\.rasi\\'" . css-mode))

(provide 'ysz-lang)
;;; ysz-lang.el ends here
