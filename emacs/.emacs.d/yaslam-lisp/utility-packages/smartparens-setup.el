(require 'smartparens)
(dolist (hook '(emacs-lisp-mode-hook
		lisp-mode-hook))
  (add-hook hook (lambda () (progn (smartparens-mode)
				   (smartparens-strict-mode)))))

(setq sp-pairs (quote ((t
			(:open "\\\\(" :close "\\\\)" :actions
			       (insert wrap autoskip navigate))
			(:open "\\{" :close "\\}" :actions
			       (insert wrap autoskip navigate))
			(:open "\\(" :close "\\)" :actions
			       (insert wrap autoskip navigate))
			(:open "\\\"" :close "\\\"" :actions
			       (insert wrap autoskip navigate))
			(:open "\"" :close "\"" :actions
			       (insert wrap autoskip navigate escape)
			       :unless
			       (sp-in-string-quotes-p)
			       :post-handlers
			       (sp-escape-wrapped-region sp-escape-quotes-after-insert))
			;; (:open "'" :close "'" :actions
			;; (insert wrap autoskip navigate escape)
			;; :unless
			;; (sp-in-string-quotes-p sp-point-after-word-p)
			;; :post-handlers
			;; (sp-escape-wrapped-region sp-escape-quotes-after-insert))
			(:open "(" :close ")" :actions
			       (insert wrap autoskip navigate))
			(:open "[" :close "]" :actions
			       (insert wrap autoskip navigate))
			(:open "{" :close "}" :actions
			       (insert wrap autoskip navigate))))))
			;; (:open "`" :close "'" :actions
			;; (insert wrap autoskip navigate))))))

(let ((map smartparens-mode-map))
  (keymap-set map "C-M-d" #'sp-splice-sexp)
  (keymap-set map "C-M-k" #'sp-kill-sexp)
  (keymap-set map "C-k" #'sp-kill-hybrid-sexp)
  (keymap-set map "C-j" #'sp-newline)
  ;; S-expression navigation
  (keymap-set map "C-M-f" #'sp-forward-sexp)
  (keymap-set map "C-M-b" #'sp-backward-sexp)
  (keymap-set map "C-M-n" #'sp-next-sexp)
  (keymap-set map "C-M-p" #'sp-previous-sexp)
  (keymap-set map "C-S-f" #'sp-forward-symbol)
  (keymap-set map "C-S-b" #'sp-backward-symbol)
  ;; Slurping/barfing s-expressions
  ;; I.e adding brackets around sexp's in an intelligent way and
  ;; removing brackets from around sexp's in an intelligent way.
  (keymap-set map "C-<right>" #'sp-forward-slurp-sexp)
  (keymap-set map "C-<left>" #'sp-backward-slurp-sexp)
  (keymap-set map "M-<right>" #'sp-forward-barf-sexp)
  (keymap-set map "M-<left>" #'sp-backward-barf-sexp)
  ;; Unwrapping s-exps :: https://ebzzry.com/en/emacs-pairs/#unwrapping
  (keymap-set map "M-[" #'sp-backward-unwrap-sexp)
  (keymap-set map "M-]" #'sp-unwrap-sexp)
  (keymap-set map "M-i" #'sp-change-inner)
  (keymap-set map "M-;" #'sp-comment)
  (keymap-set map "C-c p" #'smartparens-strict-mode)
  ;; Transposing s-expressions
  (keymap-set map "C-M-t" #'sp-transpose-sexp))

(provide 'smartparens-setup)
