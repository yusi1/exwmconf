(require 'elisp-format)

(progn
  (gkey "C-c z f" 'elisp-format-file)
  (gkey "C-c z r" 'elisp-format-region))

(provide 'elisp-format-setup)
