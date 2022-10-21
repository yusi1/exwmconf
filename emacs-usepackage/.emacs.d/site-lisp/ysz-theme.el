(use-package modus-themes
  :straight t
  :demand t
  :bind (("<f12>" . modus-themes-toggle))
  :config
  (setq modus-themes-mode-line '(3d accented))
  (modus-themes-load-vivendi))

(provide 'ysz-theme)
