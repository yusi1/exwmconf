(require 'iedit)

(let ((map global-map))
  (define-key map (kbd "C-;") 'iedit-mode)
  (define-key map (kbd "C-c ;") 'iedit-mode))

(provide 'iedit-setup)
