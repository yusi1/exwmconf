(require 'multiple-cursors)

(setq mc/max-cursors 10)

(progn
  (gkey "C-S-c C-S-c" 'mc/edit-lines)
  (gkey "C->" 'mc/mark-next-like-this)
  (gkey "C-<" 'mc/mark-previous-like-this)
  (gkey "C-c C-<" 'mc/mark-all-like-this)
  (gkey "C-)" 'mc/cycle-forward)
  (gkey "C-(" 'mc/cycle-backward))

(keymap-set mc/keymap "<escape>" 'mc/keyboard-quit)

(provide 'multiple-cursors-setup)
