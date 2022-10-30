(require 'org-modern)
;; (require 'org-modern-indent)

;; (add-hook 'org-mode-hook (lambda () (org-modern-indent-mode)))

;; Enable `global-org-modern-mode' if we are on a graphical display.
(if (display-graphic-p)
    (global-org-modern-mode))

;; `org-modern' configuration
(setq
 ;; Enable/Disable modern styling for code blocks and other blocks.
 org-modern-block t
 ;; Enable/Disable modern styling for tags.
 org-modern-tag t
 ;; Enable/Disable modern styling for todo labels.
 org-modern-todo t
 ;; Enable/Disable modern styling for tables.
 org-modern-table t
 ;; Enable/Disable modern styling for keywords.
 org-modern-keyword t
 ;; Enable/Disable modern styling for priority keywords.
 org-modern-priority t
 ;; Enable/Disable modern styling for timestamps.
 org-modern-timestamp t
 ;; Enable/Disable modern styling for statistics.
 org-modern-statistics t
 ;; Enable/Disable modern styling for horizontal rulers.
 org-modern-horizontal-rule t)

(provide 'org-modern-setup)