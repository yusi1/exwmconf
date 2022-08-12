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
  (define-key map (kbd "C-M-d") #'sp-splice-sexp)
  (define-key map (kbd "C-M-k") #'sp-kill-sexp)
  (define-key map (kbd "C-k") #'sp-kill-hybrid-sexp)
  (define-key map (kbd "C-j") #'sp-newline)
  ;; S-expression navigation
  (define-key map (kbd "C-M-f") #'sp-forward-sexp)
  (define-key map (kbd "C-M-b") #'sp-backward-sexp)
  (define-key map (kbd "C-M-n") #'sp-next-sexp)
  (define-key map (kbd "C-M-p") #'sp-previous-sexp)
  (define-key map (kbd "C-S-f") #'sp-forward-symbol)
  (define-key map (kbd "C-S-b") #'sp-backward-symbol)
  ;; Slurping/barfing s-expressions
  ;; I.e adding brackets around sexp's in an intelligent way and
  ;; removing brackets from around sexp's in an intelligent way.
  (define-key map (kbd "C-<right>") #'sp-forward-slurp-sexp)
  (define-key map (kbd "C-<left>") #'sp-backward-slurp-sexp)
  (define-key map (kbd "M-<right>") #'sp-forward-barf-sexp)
  (define-key map (kbd "M-<left>") #'sp-backward-barf-sexp)
  ;; Unwrapping s-exps :: https://ebzzry.com/en/emacs-pairs/#unwrapping
  (define-key map (kbd "M-[") #'sp-backward-unwrap-sexp)
  (define-key map (kbd "M-]") #'sp-unwrap-sexp)
  (define-key map (kbd "M-i") #'sp-change-inner)
  (define-key map (kbd "M-;") #'sp-comment)
  (define-key map (kbd "C-c p") #'smartparens-strict-mode)
  ;; Transposing s-expressions
  (define-key map (kbd "C-M-t") #'sp-transpose-sexp))

(provide 'smartparens-setup)
