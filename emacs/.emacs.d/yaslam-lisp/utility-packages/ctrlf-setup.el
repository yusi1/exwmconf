(require 'ctrlf)

(let ((map ctrlf-mode-map))
  ;; (define-key map (kbd "<right>") 'ctrlf-forward-fuzzy)
  ;; (define-key map (kbd "<left>") 'ctrlf-backward-fuzzy)
  (define-key map (kbd "C-s") 'ctrlf-forward-default)
  (define-key map (kbd "C-r") 'ctrlf-backward-default)
  (define-key map (kbd "M-s _") 'ctrlf-forward-symbol)
  (define-key map (kbd "M-s .") 'ctrlf-forward-symbol-at-point))

(let ((map ctrlf-minibuffer-mode-map))
  (define-key map (kbd "M->") 'ctrlf-last-match)
  (define-key map (kbd "M-<") 'ctrlf-first-match)
  (define-key map (kbd "C-v") 'ctrlf-next-page)
  (define-key map (kbd "M-v") 'ctrlf-previous-page)
  (define-key map (kbd "C-g") 'ctrlf-cancel))	; Isearch-like behaviour

;; (let ((map view-mode-map))
;;   (define-key map (kbd "s") 'ctrlf-forward-default)
;;   (define-key map (kbd "r") 'ctrlf-backward-default))

(ctrlf-mode t)

(provide 'ctrlf-setup)
