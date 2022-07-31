(require 'embark)

(let ((map global-map))
  (define-key map (kbd "C-.") 'embark-act)         ;; pick some comfortable binding
  (define-key map (kbd "C-x A") 'embark-act)
  (define-key map (kbd "C-#") 'embark-dwim)        ;; good alternative: M-.
  (define-key map (kbd "C-h B") 'embark-bindings))

;; Optionally replace the key help with a completing-read interface
;; Can replace the `which-key' package too.
(setq prefix-help-command #'embark-prefix-help-command)

;; Hide the mode line of the Embark live/completions buffers
(add-to-list 'display-buffer-alist
             '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
               nil
               (window-parameters (mode-line-format . none))))

(provide 'embark-setup)
