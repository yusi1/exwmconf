;;; Git configurations (magit et al.) --- ysz-git.el

;; (use-package magit
;;   :straight t
;;   :config
;;   (if (eq system-type 'windows-nt)
;;       ;; Use Git4Windows executable instead of MingW or anything else.
;;       (setq magit-git-executable "C:/Program Files/Git/cmd/git.exe")))
;;   ;; (keymap-set global-map "C-x g" 'magit)
  

(use-package vc
  :config
  (setq vc-follow-symlinks t)
  (keymap-set global-map "C-x g" 'project-vc-dir))
;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package agitate
  :straight t
  :config
  (define-key vc-git-log-edit-mode-map (kbd "C-c C-n") 'agitate-log-edit-insert-file-name))

(provide 'ysz-git)
;;; ysz-git.el ends here
