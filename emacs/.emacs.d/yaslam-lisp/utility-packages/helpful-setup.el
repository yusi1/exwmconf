(require 'helpful)

(let ((map global-map))
  (define-key map (kbd "C-h f") 'helpful-callable)
  (define-key map (kbd "C-h v") 'helpful-variable)
  (define-key map (kbd "C-h k") 'helpful-key)
  (define-key map (kbd "C-h F") 'helpful-function)
  (define-key map (kbd "C-c C-d") 'helpful-at-point)
  (define-key map (kbd "C-h C") 'helpful-command))

(provide 'helpful-setup)
