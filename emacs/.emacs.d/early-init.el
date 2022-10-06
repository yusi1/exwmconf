;; Disable startup screen
(setq inhibit-startup-screen t)

(setq initial-frame-alist
      '((width . 76)
	(height . 32)))

;; Frame configuration
;; Add frame borders and window dividers
;; (modify-all-frames-parameters
;;  '((right-divider-width . 0)
;;    (internal-border-width . 0)))
;; (dolist (face '(window-divider
;;                 window-divider-first-pixel
;;                 window-divider-last-pixel))
;;   (face-spec-reset-face face)
;;   (set-face-foreground face (face-attribute 'default :background)))
;; (set-face-background 'fringe (face-attribute 'default :background))
