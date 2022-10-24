;;; Completion configurations (vertico, orderless et al.) --- ysz-completion.el

(use-package orderless
  :straight t
  :init
  (setq completion-styles '(orderless basic)
	completion-category-defaults nil
	completion-category-overrides '((file (styles . (partial-completion))))))

(use-package vertico
  :straight t
  :init
  (vertico-mode 1))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package vertico-mouse
  :load-path "straight/repos/vertico/extensions"
  :after (vertico)
  :config
  (vertico-mouse-mode 1))
(use-package vertico-directory
  :load-path "straight/repos/vertico/extensions"
  :after (vertico)
  :bind ((:map vertico-map
               ("RET" . vertico-directory-enter)
               ("DEL" . vertico-directory-delete-char)
               ("M-DEL" . vertico-directory-delete-word)))
  :hook (rfn-eshadow-update-overlay . vertico-directory-tidy))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package vertico-multiform
  :load-path "straight/repos/vertico/extensions"
  :after (vertico vertico-unobtrusive
		  vertico-reverse vertico-grid
		  vertico-flat vertico-buffer)
  :config
  (let ((map vertico-map))
    (keymap-set map "M-V" #'vertico-multiform-vertical)
    (keymap-set map "M-G" #'vertico-multiform-grid)
    (keymap-set map "M-F" #'vertico-multiform-flat)
    (keymap-set map "M-R" #'vertico-multiform-reverse)
    (keymap-set map "M-U" #'vertico-multiform-unobtrusive))
  (setq vertico-multiform-commands
	'((consult-imenu buffer)
	  (execute-extended-command flat)))
  (vertico-multiform-mode t))
;;;;;;;;;;;;;;;;;;;;;;;
(use-package vertico-unobtrusive
  :load-path "straight/repos/vertico/extensions"
  :after (vertico))
(use-package vertico-reverse
  :load-path "straight/repos/vertico/extensions"
  :after (vertico))
(use-package vertico-grid
  :load-path "straight/repos/vertico/extensions"
  :after (vertico))
(use-package vertico-flat
  :load-path "straight/repos/vertico/extensions"
  :after (vertico))
(use-package vertico-buffer
  :load-path "straight/repos/vertico/extensions"
  :after (vertico)
  :init
  (setq vertico-buffer-display-action '((display-buffer-in-side-window)
					(window-height . 10)
					(side . bottom))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package savehist
  :straight t
  :config
  (savehist-mode)
  (add-to-list 'savehist-additional-variables 'vertico-repeat-history))

(use-package corfu
  :straight t
  :config
  (let ((map corfu-map))
    (keymap-set map "M-p" 'nil)
    (keymap-set map "M-n" 'nil))
  (setq tab-always-indent 'complete)
  (setq completion-cycle-threshold 3)
  (global-corfu-mode 1))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package corfu-doc
  :straight t
  :after (corfu)
  :demand t
  :config
  (let ((map corfu-map))
    (keymap-set map "M-p" 'corfu-doc-scroll-down)
    (keymap-set map "M-n" 'corfu-doc-scroll-up)
    (keymap-set map "M-d" 'corfu-doc-toggle))
  (corfu-doc-mode 1))

(use-package marginalia
  :straight t
  :init
  (marginalia-mode))

(use-package consult
  :straight t
  :demand t
  :bind (;; ("C-x b" . consult-buffer)
	 ("C-c i" . consult-imenu)
	 ("M-y" . consult-yank-pop))
  :hook (completion-list-mode . consult-previous-at-point-mode)
  :config
  (setq consult-buffer-sources (quote
				(consult--source-hidden-buffer
				 consult--source-buffer
				 ;; consult--source-recent-file
				 ))))

(provide 'ysz-completion)
;;; ysz-completion.el ends here
