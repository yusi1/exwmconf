;;; Theming configurations --- ysz-theme.el

(use-package modus-themes
  :straight t
  :demand t
  :bind (("<f12>" . modus-themes-toggle))
  :config
  (setq modus-themes-mode-line '(3d accented))
  (setq modus-themes-headings '((1 . (light variable-pitch 1.5))
				(2 . (monochrome 1.05))
				(t . (semibold))))
  (modus-themes-load-vivendi))

(provide 'ysz-theme)
;;; ysz-theme.el ends here
