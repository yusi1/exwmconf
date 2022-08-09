(require 'consult)
(require 'consult-notmuch)

(let ((map global-map))
  (define-key map (kbd "C-x b") 'consult-buffer)
  (define-key map (kbd "C-c i") 'consult-imenu)
  (define-key map (kbd "M-y") 'consult-yank-pop)
  (define-key map (kbd "C-c i") 'consult-imenu))

(add-hook 'completion-list-mode-hook 'consult-preview-at-point-mode)

;; Show less things in `consult-buffer'.
(setq consult-buffer-sources (quote
			      (consult--source-hidden-buffer
			       consult--source-buffer
			       consult--source-recent-file
			       consult-notmuch-buffer-source)))

(provide 'consult-setup)
