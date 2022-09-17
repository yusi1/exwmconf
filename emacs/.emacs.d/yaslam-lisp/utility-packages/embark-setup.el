(require 'embark)

(progn
  (gkey "C-." 'embark-act)         ;; pick some comfortable binding
  (gkey "C-x A" 'embark-act)
  (gkey "C-#" 'embark-dwim)        ;; good alternative: M-.
  (gkey "C-h B" 'embark-bindings))

;; Optionally replace the key help with a completing-read interface
;; Can replace the `which-key' package too.
(setq prefix-help-command #'embark-prefix-help-command)

;; Hide the mode line of the Embark live/completions buffers
(add-to-list 'display-buffer-alist
             '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
               nil
               (window-parameters (mode-line-format . none))))

;; Replace some commands with their respective helpful variants
(defalias 'describe-symbol 'helpful-symbol)
(defalias 'describe-variable 'helpful-variable)

(provide 'embark-setup)
