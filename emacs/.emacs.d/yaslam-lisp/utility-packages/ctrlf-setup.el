(require 'ctrlf)

(let ((map ctrlf-mode-map))
  ;; (keymap-set map "<right>" 'ctrlf-forward-fuzzy)
  ;; (keymap-set map "<left>" 'ctrlf-backward-fuzzy)
  (keymap-set map "C-s" 'ctrlf-forward-default)
  (keymap-set map "C-r" 'ctrlf-backward-default)
  (keymap-set map "M-s _" 'ctrlf-forward-symbol)
  (keymap-set map "M-s ." 'ctrlf-forward-symbol-at-point))

(let ((map ctrlf-minibuffer-mode-map))
  (keymap-set map "M->" 'ctrlf-last-match)
  (keymap-set map "M-<" 'ctrlf-first-match)
  (keymap-set map "C-v" 'ctrlf-next-page)
  (keymap-set map "M-v" 'ctrlf-previous-page)
  (keymap-set map "C-g" 'ctrlf-cancel))	; Isearch-like behaviour

;; (let ((map view-mode-map))
;;   (keymap-set map "s" 'ctrlf-forward-default)
;;   (keymap-set map "r" 'ctrlf-backward-default))

(ctrlf-mode t)

(provide 'ctrlf-setup)
