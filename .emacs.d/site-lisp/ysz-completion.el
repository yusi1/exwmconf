;;; Completion configurations (vertico, orderless et al.) --- ysz-completion.el

(use-package general
  :straight t)

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
    (define-key map (kbd "M-V") #'vertico-multiform-vertical)
    (define-key map (kbd "M-G") #'vertico-multiform-grid)
    (define-key map (kbd "M-F") #'vertico-multiform-flat)
    (define-key map (kbd "M-R") #'vertico-multiform-reverse)
    (define-key map (kbd "M-U") #'vertico-multiform-unobtrusive))
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
    (define-key map (kbd "M-p") 'nil)
    (define-key map (kbd "M-n") 'nil))
  (setq tab-always-indent 'complete)
  (setq completion-cycle-threshold 3)
  (global-corfu-mode 1)
  ;; enable corfu in the minibuffer
  (defun corfu-enable-in-minibuffer ()
    "Enable Corfu in the minibuffer if `completion-at-point' is bound."
    (when (where-is-internal #'completion-at-point (list (current-local-map)))
      ;; (setq-local corfu-auto nil) Enable/disable auto completion
      (corfu-mode 1)))
  (add-hook 'minibuffer-setup-hook #'corfu-enable-in-minibuffer))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package corfu-popupinfo
  :load-path "straight/repos/corfu/extensions"
  :after (corfu)
  :demand t
  :config
  (let ((map corfu-map))
    (define-key map (kbd "M-p") 'corfu-popupinfo-scroll-down)
    (define-key map (kbd "M-n") 'corfu-popupinfo-scroll-up)
    (define-key map (kbd "M-d") 'corfu-popupinfo-toggle))
  ;; Change height of `corfu-popinfo' face.
  (set-face-attribute 'corfu-popupinfo nil :height 1.0)
  (corfu-popupinfo-mode 1))

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
                                 consult--source-buffer))))
                                 ;; consult--source-recent-file
                                 

(use-package cape
  :straight t
  :demand t
  :config
  ;; Bind dedicated completion commands
  ;; Alternative prefix keys: C-c p, M-p, M-+, ...
  (general-def global-map
    :prefix "C-c ["
    "p" 'completion-at-point ;; capf
    "t" 'complete-tag        ;; etags
    "d" 'cape-dabbrev        ;; or dabbrev-completion
    "h" 'cape-history
    "f" 'cape-file
    "k" 'cape-keyword
    "s" 'cape-symbol
    "a" 'cape-abbrev
    "i" 'cape-ispell
    "l" 'cape-line
    "w" 'cape-dict
    "\\" 'cape-tex
    "_" 'cape-tex
    "^" 'cape-tex
    "&" 'cape-sgml
    "r" 'cape-rfc1345)

   ;; Add `completion-at-point-functions', used by `completion-at-point'.
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file))

(provide 'ysz-completion)
;;; ysz-completion.el ends here
