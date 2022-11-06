;;; Configurations for extra language packages --- ysz-lang.el

(use-package markdown-mode
  :straight t)

(use-package haskell-mode
  :straight t)

(add-to-list 'auto-mode-alist '("\\.rasi\\'" . css-mode))

(provide 'ysz-lang)
;;; ysz-lang.el ends here
