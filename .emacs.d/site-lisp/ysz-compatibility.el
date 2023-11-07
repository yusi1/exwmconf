;;; Functions to maintain compatibility between older Emacs versions --- ysz-compatibility.el

;; (unless (fboundp 'keymap-set)
;;   (defmacro keymap-set (map key func)
;;     `(define-key ,map (kbd ,key) ,func)))

(provide 'ysz-compatibility)
;;; ysz-compatibility.el ends here
