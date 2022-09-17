(require 'helpful)

(progn
  (gkey "C-h f" 'helpful-callable)
  (gkey "C-h v" 'helpful-variable)
  (gkey "C-h k" 'helpful-key)
  (gkey "C-h F" 'helpful-function)
  (gkey "C-c C-d" 'helpful-at-point)
  (gkey "C-h C" 'helpful-command))

(provide 'helpful-setup)
