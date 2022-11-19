;;; Git configurations (magit et al.) --- ysz-git.el

(use-package magit
  :straight t
  :config
  (if (eq system-type 'windows-nt)
      ;; Use Git4Windows executable instead of MingW or anything else.
      (setq magit-git-executable "C:/Program Files/Git/cmd/git.exe"))
  (keymap-set global-map "C-x g" 'magit))

(provide 'ysz-git)
;;; ysz-git.el ends here
