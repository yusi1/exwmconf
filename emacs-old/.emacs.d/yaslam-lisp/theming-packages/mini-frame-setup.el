(require 'mini-frame)
(require 'posframe)

(setq mini-frame-show-parameters '((top . 20)
				   (width . 0.7)
				   (left . 0.5)
				   (left-fringe . 1)
				   (right-fringe . 1)))

(setq mini-frame-color-shift-step 27)

;; (defun get-tooltip-color ()
;;   "Get color used by the tooltip face."
;;   (face-background 'tooltip))

;; (setq mini-frame-background-color-function 'get-tooltip-color)
;; (setq mini-frame-background-color-function (lambda ()
;; (face-background 'default)))

(setq mini-frame-internal-border-color nil)

;; (set-face-background 'child-frame-border "#000000")
;; (set-face-attribute 'child-frame-border-width 0)

;; fix issue with `consult-imenu'
(add-to-list 'mini-frame-ignore-commands 'consult-imenu)

(mini-frame-mode t)

(provide 'mini-frame-setup)
