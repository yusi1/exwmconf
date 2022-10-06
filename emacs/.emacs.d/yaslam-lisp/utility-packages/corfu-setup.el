(require 'corfu)
(require 'corfu-doc)
(require 'corfu-terminal)
(require 'corfu-doc-terminal)

;; when in terminals, enable `corfu-terminal-mode'.
(unless (display-graphic-p)
  (corfu-terminal-mode +1)
  (corfu-doc-terminal-mode +1))
;; documentation in corfu popup
(corfu-doc-mode)
(global-corfu-mode)

;; enable corfu in the minibuffer
(defun corfu-enable-in-minibuffer ()
       "Enable Corfu in the minibuffer if `completion-at-point' is bound."
       (when (where-is-internal #'completion-at-point (list (current-local-map)))
         ;; (setq-local corfu-auto nil) Enable/disable auto completion
         (corfu-mode 1)))
(add-hook 'minibuffer-setup-hook #'corfu-enable-in-minibuffer)

;; TAB cycle if there are only few candidates
(setq completion-cycle-threshold 3)

;; Use TAB key to initiate completion.
(setq tab-always-indent 'complete)

(provide 'corfu-setup)
