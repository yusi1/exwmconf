(require 'perspective)
;; perspective.el EXWM integration
(require 'perspective-exwm)
(perspective-exwm-mode)

(gkey "C-x M-b" 'persp-list-buffers)

(customize-set-variable 'persp-mode-prefix-key (kbd "C-c M-p"))

(persp-mode)

(provide 'perspective-setup)
