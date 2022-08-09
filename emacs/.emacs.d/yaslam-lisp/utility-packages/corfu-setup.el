(require 'corfu)
(global-corfu-mode)

;; TAB cycle if there are only few candidates
(setq completion-cycle-threshold 3)

;; Use TAB key to initiate completion.
(setq tab-always-indent 'complete)

(provide 'corfu-setup)
