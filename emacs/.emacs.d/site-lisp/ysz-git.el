;;; Git configurations (magit et al.) --- ysz-git.el

(use-package magit
  :straight t
  :config
  (keymap-set global-map "C-x g" 'magit))

(provide 'ysz-git)
;;; ysz-git.el ends here
