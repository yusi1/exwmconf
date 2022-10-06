;; Fix issue #60 in evil-collection
(setq evil-want-keybinding nil)

(require 'evil)
(require 'evil-smartparens)
(require 'evil-mc)
(require 'evil-multiedit)
(require 'evil-org)
(require 'evil-org-agenda)
(require 'evil-collection)

;; Setting up evil-collection
(evil-collection-init '(magit eshell helpful pass notmuch ibuffer eww bookmark dictionary custom info compile))

;; ;; . in visual mode
;; (defun moon/make-region-search-history ()
;;   "Make region a history so I can use cgn."
;;   (interactive)
;;   (let ((region (strip-text-properties (funcall region-extract-function nil))))
;;     (push region evil-ex-search-history)
;;     (setq evil-ex-search-pattern (evil-ex-make-search-pattern region))
;;     (evil-ex-search-activate-highlight evil-ex-search-pattern)
;;     (deactivate-mark)))

;; (evil-define-key 'visual 'global (kbd ".") 'moon/make-region-search-history)

;; Leader key mappings
(evil-set-leader 'normal (kbd "SPC"))
(evil-define-key 'normal 'global (kbd "<leader>ff") 'find-file)
(evil-define-key 'normal 'global (kbd "<leader>fs") 'save-buffer)
(evil-define-key 'normal 'global (kbd "<leader>fr") 'recentf)
(evil-define-key 'normal 'global (kbd "<leader>bb") 'consult-buffer)
(evil-define-key 'normal 'global (kbd "<leader>bk") 'kill-buffer)
(evil-define-key 'normal 'global (kbd "<leader>b;") 'other-window-kill-buffer)
(evil-define-key 'normal 'global (kbd "<leader>o") 'other-window)
(evil-define-key 'normal 'global (kbd "<leader>0") 'delete-window)
(evil-define-key 'normal 'global (kbd "<leader>1") 'delete-other-windows)
(evil-define-key 'normal 'global (kbd "<leader>2") 'split-window-below)
(evil-define-key 'normal 'global (kbd "<leader>3") 'split-window-right)
(evil-define-key 'normal 'global (kbd "<leader>]") 'sp-forward-slurp-sexp)
(evil-define-key 'normal 'global (kbd "<leader>[") 'sp-backward-slurp-sexp)
(evil-define-key 'normal 'global (kbd "<leader>{") 'sp-backward-unwrap-sexp)
(evil-define-key 'normal 'global (kbd "<leader>}") 'sp-unwrap-sexp)
(evil-define-key 'normal 'global (kbd "<leader>wn") 'next-window-any-frame)
(evil-define-key 'normal 'global (kbd "<leader>wp") 'previous-window-any-frame)

;; Visual state mappings
(evil-define-key 'visual 'global "gc" 'comment-region)

;; Motion state mappings
(evil-define-key 'motion 'global "gcc" 'comment-line)

;; Mode mappings
;; (evil-define-key 'normal 'notmuch-show "gn" 'notmuch-show-next-open-message)
;; (evil-define-key 'normal 'notmuch-show "gp" 'notmuch-show-previous-open-message)

;; evil mode org mode keybind integration `evil-org'.
(add-hook 'org-mode-hook 'evil-org-mode)
(evil-org-set-key-theme '(navigation insert textobjects additional calendar))
(evil-org-agenda-set-keys)

;; Info mode turn off evil
(add-hook 'Info-mode-hook 'turn-off-evil-mode)

;; Prog mode turn on evil smartparens mode
(add-hook 'prog-mode-hook 'evil-smartparens-mode)

;; Turn on evil multiple-cursors mode globally 
(global-evil-mc-mode 1)

;; Load evil-multiedit with default keybinds
(evil-multiedit-default-keybinds)

(evil-mode 1)

(provide 'evil-setup)
