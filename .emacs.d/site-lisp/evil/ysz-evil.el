;;; EviL mode configurations --- ysz-evil.el

(use-package evil
  :straight t
  :preface
  (setq evil-want-keybinding nil)
  (setq evil-undo-system 'undo-redo) ; Enables Ctrl-R redo
  :hook ((Info-mode . turn-off-evil-mode))
  :init
  (evil-mode 1)
  :config
  ;; Leader key mappings
  (evil-set-leader 'normal (kbd "SPC"))
  ;; INFO: You need to use `kbd' if setting <leader> key-binds.
  (evil-define-key 'normal 'global
    (kbd "<leader>ff") 'find-file
    (kbd "<leader>fs") 'save-buffer
    (kbd "<leader>;") 'save-buffer
    (kbd "<leader>fr") 'recentf
    (kbd "<leader>bb") 'consult-buffer
    (kbd "<leader>bk") 'kill-buffer
    (kbd "<leader>b;") 'other-window-kill-buffer
    (kbd "<leader>o") 'other-window
    (kbd "<leader>0") 'delete-window
    (kbd "<leader>1") 'delete-other-windows
    (kbd "<leader>2") 'split-window-below
    (kbd "<leader>3") 'split-window-right
    (kbd "<leader>wn") 'next-window-any-frame
    (kbd "<leader>wp") 'previous-window-any-frame)

  ;; Visual state mappings
  (evil-define-key 'visual 'global "gc" 'comment-dwim)
  ;; Motion state mappings
  (evil-define-key 'motion 'global "gcc" 'comment-line)
  (evil-define-key 'motion 'global "gQ" 'quit-window)
  ;;; Mode mappings
  ;; (evil-define-key 'normal 'notmuch-show "gn" 'notmuch-show-next-open-message)
  ;; (evil-define-key 'normal 'notmuch-show "gp" 'notmuch-show-previous-open-message)
  (evil-define-key 'normal 'rmail-mode-map "g>" 'rmail-last-message)
  (evil-define-key 'normal 'rmail-mode-map "g<" 'rmail-first-message))

(use-package evil-org
  :straight t
  :after (evil org)
  :hook ((org-mode . evil-org-mode))
  :config
  (evil-org-set-key-theme '(navigation insert textobjects additional calendar)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package evil-org-agenda
  ;; :straight t
  :after (evil evil-org)
  :config
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys)) 

;; (use-package evil-smartparens
;;   :straight t
;;   :after (evil)
;;   :hook (prog-mode . evil-smartparens-mode)
;;   :config
;;   (evil-define-key 'normal 'global
;;     (kbd "<leader>]") 'sp-forward-slurp-sexp
;;     (kbd "<leader>[") 'sp-backward-slurp-sexp
;;     (kbd "<leader>{") 'sp-backward-unwrap-sexp
;;     (kbd "<leader>}") 'sp-unwrap-sexp))

(use-package evil-multiedit
  :straight t
  :after (evil)
  :config
  ;; Load evil-multiedit with default keybinds
  (evil-multiedit-default-keybinds))

(use-package evil-collection
  :straight t
  :after (evil)
  :config
  ;; Setting up evil-collection
  (evil-collection-init '(magit eshell helpful pass notmuch ibuffer eww bookmark dictionary custom info compile gnus vc-dir man)))

(provide 'ysz-evil)
;;; ysz-evil.el ends here
