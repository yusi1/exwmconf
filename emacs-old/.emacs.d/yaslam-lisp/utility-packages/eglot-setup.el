(require 'eglot)

(defun setup-ide-stuff ()
  "Minor modes that are useful when programming."
  (interactive)
  (eglot-ensure)
  (corfu-mode))

;; (dolist (hooks '(sh-mode-hook
;; 		 python-mode-hook))
;;   (add-hook hooks 'setup-ide-stuff))

(provide 'eglot-setup)
