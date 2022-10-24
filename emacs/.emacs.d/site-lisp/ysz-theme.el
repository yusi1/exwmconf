;;; Theming configurations --- ysz-theme.el

(use-package cursory
  :straight t
  :bind (("C-c C-p" . cursory-set-preset))
  :config
  (setq cursory-presets
	'((bar
           :cursor-type (bar . 2)
           :cursor-in-non-selected-windows hollow
           :blink-cursor-blinks 10
           :blink-cursor-interval 0.5
           :blink-cursor-delay 0.2)
	  (slow-bar
	   :cursor-type (bar . 2)
	   :cursor-in-non-selected-windows hollow
	   :blink-cursor-blinks 3
	   :blink-cursor-interval 0.8
	   :blink-cursor-delay 0.5)
          (box
           :cursor-type box
           :cursor-in-non-selected-windows hollow
           :blink-cursor-blinks 10
           :blink-cursor-interval 0.5
           :blink-cursor-delay 0.2)
          (underscore
           :cursor-type (hbar . 3)
           :cursor-in-non-selected-windows hollow
           :blink-cursor-blinks 50
           :blink-cursor-interval 0.2
           :blink-cursor-delay 0.2)))
  (setq cursory-latest-state-file (locate-user-emacs-file "cursory-latest-state"))
  (cursory-set-preset (or (cursory-restore-latest-preset) 'box))
  (add-hook 'kill-emacs-hook #'cursory-store-latest-preset))

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
