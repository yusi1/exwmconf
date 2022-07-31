(require 'multiple-cursors)

(setq mc/max-cursors 10)

(let ((map global-map))
  (define-key map (kbd "C-S-c C-S-c") 'mc/edit-lines)
  (define-key map (kbd "C->") 'mc/mark-next-like-this)
  (define-key map (kbd "C-<") 'mc/mark-previous-like-this)
  (define-key map (kbd "C-c C-<") 'mc/mark-all-like-this)
  (define-key map (kbd "C-)") 'mc/cycle-forward)
  (define-key map (kbd "C-(") 'mc/cycle-backward))

(define-key mc/keymap (kbd "<escape>")
  'mc/keyboard-quit)

(provide 'multiple-cursors-setup)
