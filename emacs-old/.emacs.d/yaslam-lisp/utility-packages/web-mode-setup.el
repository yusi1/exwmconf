(require 'web-mode)

(setq web-mode-engines-alist
      '(("html" . "\\.html?\\'")
	("css" . "\\.css\\'")
	("js" . "\\.js\\'")))

(setq web-mode-extra-snippets
      '(("html" . (("code" . "<code>|</code>")))))

(setq web-mode-enable-block-face t)

(progn
  (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.css\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode)))

(provide 'web-mode-setup)
