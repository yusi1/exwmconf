(require 'fussy)

(setq
 ;; For example, project-find-file uses 'project-files which uses
 ;; substring completion by default. Set to nil to make sure it's using
 ;; flx.
 completion-category-defaults nil
 completion-category-overrides nil)
(setq completion-styles '(fussy))

(setq fussy-use-cache t)

(defun j-company-capf (f &rest args)
  "Manage `completion-styles'."
  (if (length= company-prefix 0)
      ;; Don't use `company' for 0 length prefixes.
      (let ((completion-styles (remq 'fussy completion-styles)))
        (apply f args))
    (let ((fussy-max-candidate-limit 5000)
          (fussy-default-regex-fn 'fussy-pattern-first-letter)
          (fussy-prefer-prefix nil))
      (apply f args))))

(defun j-company-transformers (f &rest args)
  "Manage `company-transformers'."
  (if (length= company-prefix 0)
      ;; Don't use `company' for 0 length prefixes.
      (apply f args)
    (let ((company-transformers '(fussy-company-sort-by-completion-score)))
      (apply f args))))

(advice-add 'company-auto-begin :before 'fussy-wipe-cache)
(advice-add 'company--transform-candidates :around 'j-company-transformers)
(advice-add 'company-capf :around 'j-company-capf)

(provide 'fussy-setup)
