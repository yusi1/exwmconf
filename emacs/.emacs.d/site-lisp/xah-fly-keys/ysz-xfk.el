;;; Xah-Fly-Keys configurations --- ysz-xfk.el

(use-package xah-fly-keys
  :straight t
  :preface
  ;; must come before loading xah-fly-keys
  (setq xah-fly-use-control-key nil)
  (setq xah-fly-use-meta-key nil)
  (setq xah-fly-unset-useless-key nil)
  :config
  ;; specify a layout
  (xah-fly-keys-set-layout "qwerty")

  (defun set-box ()
    (cursory-set-preset 'box))

  (defun set-bar ()
    (cursory-set-preset 'bar))

  (add-hook 'xah-fly-command-mode-activate-hook 'set-box)
  (add-hook 'xah-fly-insert-mode-activate-hook 'set-bar)

  (defun xah-fly-mode-toggle ()
    "Switch between {insertion, command} modes."
    (interactive)
    (if xah-fly-insert-state-p
	(xah-fly-command-mode-activate)
      (xah-fly-insert-mode-activate)))

  (general-def "<end>" 'xah-fly-mode-toggle)

  (xah-fly-keys 1)

  ;; key mapping
  (general-def xah-fly-command-map
    "N" 'isearch-backward
    ":" 'scroll-up-command
    "H" 'scroll-down-command
    "L" 'recenter-top-bottom))

(provide 'ysz-xfk)
;;; ysz-xfk.el ends here
