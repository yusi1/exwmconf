(require 'doom-modeline)

;; Doom-modeline "bar is not a defined segment" bug:
;; https://github.com/seagle0128/doom-modeline/issues/505
;; This doesn't fix it for me.
(setq doom-modeline-fn-alist
      (--map
       (cons (remove-pos-from-symbol (car it)) (cdr it))
       doom-modeline-fn-alist))

(doom-modeline-mode 1)

(provide 'doom-modeline-setup)
