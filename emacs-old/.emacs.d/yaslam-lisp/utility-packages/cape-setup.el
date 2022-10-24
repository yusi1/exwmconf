(require 'cape)

;; Bind dedicated completion commands
;; Alternative prefix keys: C-c p, M-p, M-+, ...
(progn
  (gkey "C-c p p" 'completion-at-point) ;; capf
  (gkey "C-c p t" 'complete-tag)        ;; etags
  (gkey "C-c p d" 'cape-dabbrev)        ;; or dabbrev-completion
  (gkey "C-c p h" 'cape-history)
  (gkey "C-c p f" 'cape-file)
  (gkey "C-c p k" 'cape-keyword)
  (gkey "C-c p s" 'cape-symbol)
  (gkey "C-c p a" 'cape-abbrev)
  (gkey "C-c p i" 'cape-ispell)
  (gkey "C-c p l" 'cape-line)
  (gkey "C-c p w" 'cape-dict)
  (gkey "C-c p \\" 'cape-tex)
  (gkey "C-c p _" 'cape-tex)
  (gkey "C-c p ^" 'cape-tex)
  (gkey "C-c p &" 'cape-sgml)
  (gkey "C-c p r" 'cape-rfc1345))

;; Add `completion-at-point-functions', used by `completion-at-point'.
(add-to-list 'completion-at-point-functions #'cape-dabbrev)
(add-to-list 'completion-at-point-functions #'cape-file)
;;(add-to-list 'completion-at-point-functions #'cape-history)
;;(add-to-list 'completion-at-point-functions #'cape-keyword)
;;(add-to-list 'completion-at-point-functions #'cape-tex)
;;(add-to-list 'completion-at-point-functions #'cape-sgml)
;;(add-to-list 'completion-at-point-functions #'cape-rfc1345)
;;(add-to-list 'completion-at-point-functions #'cape-abbrev)
;;(add-to-list 'completion-at-point-functions #'cape-ispell)
;;(add-to-list 'completion-at-point-functions #'cape-dict)
;;(add-to-list 'completion-at-point-functions #'cape-symbol)
;;(add-to-list 'completion-at-point-functions #'cape-line)

(provide 'cape-setup)
