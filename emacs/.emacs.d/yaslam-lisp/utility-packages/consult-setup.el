(require 'consult)
(require 'consult-notmuch)

(progn
  (gkey "C-x b" 'consult-buffer)
  (gkey "C-c i" 'consult-imenu)
  (gkey "M-y" 'consult-yank-pop))

(add-hook 'completion-list-mode-hook 'consult-preview-at-point-mode)

;; Show less things in `consult-buffer'.
(setq consult-buffer-sources (quote
			      (consult--source-hidden-buffer
			       consult--source-buffer
			       consult--source-recent-file
			       consult-notmuch-buffer-source)))

(provide 'consult-setup)
