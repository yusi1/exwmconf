;;; This file contains useful functions (not functions intended to be bound to keys) --- ysz-functions.el

(defun add-list-to-list (dst src)
  "Similar to `add-to-list', but accepts a list as 2nd argument"
  (set dst
       (append (eval dst) src)))

(provide 'ysz-functions)
;;; ysz-functions.el ends here
