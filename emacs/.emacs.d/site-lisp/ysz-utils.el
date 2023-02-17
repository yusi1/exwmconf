;;; Useful configurations --- ysz-utils.el

(use-package pass
  :straight t
  :bind (("C-c p" . pass)))

(use-package org-contacts
  :straight t
  :config
  (setq org-contacts-files '("~/Documents/contacts.org"))

  (defvar ysz/my-contact-template `,(concat "* %(org-contacts-template-name)\n"
                                            ":PROPERTIES:\n"
                                            ":EMAIL: %(org-contacts-template-email)\n"
                                            ":NUMBER: %?\n"
                                            ":END:\n")
    "My org-capture contact template.")

  (dolist (templates `(("c" "Contact Parent")
                       ("c1" "Contact (Family)" entry (file+headline "~/Documents/contacts.org" "Family")
                        ,ysz/my-contact-template
                        :empty-lines 1)
                       ("c2" "Contact (Friends)" entry (file+headline "~/Documents/contacts.org" "Friends")
                        ,ysz/my-contact-template
                        :empty-lines 1)
                       ("co" "Contact (Others)" entry (file+headline "~/Documents/contacts.org" "Others")
                        ,ysz/my-contact-template
                        :empty-lines 1)))
      (add-to-list 'org-capture-templates templates)))

(use-package ibuffer-project
  :straight t
  :config
  (add-hook
   'ibuffer-hook
   (lambda ()
     (setq ibuffer-filter-groups (ibuffer-project-generate-filter-groups))
     (unless (eq ibuffer-sorting-mode 'project-file-relative)
       (ibuffer-do-sort-by-project-file-relative))))
  (add-to-list 'ibuffer-project-root-functions '(file-remote-p . "Remote")))

(use-package tempel
  :straight t
  :demand t
  :hook ((prog-mode . tempel-setup-capf)
         (text-mode . tempel-setup-capf))
  :bind (("M-+" . tempel-complete)
         ("M-*" . tempel-insert)
         (:map tempel-map
               ("TAB" . tempel-next)
               ("<backtab>" . tempel-previous)))
  :config
  (setq tempel-trigger-prefix "!")
  (defun tempel-setup-capf ()
    (setq-local completion-at-point-functions
                (cons #'tempel-expand
                      completion-at-point-functions)))

  ;; Optionally make the Tempel templates available to Abbrev,
  ;; either locally or globally. `expand-abbrev' is bound to C-x '.
  (add-hook 'prog-mode-hook #'tempel-abbrev-mode)
  (global-tempel-abbrev-mode))

(use-package chatgpt
  :straight (:host github :repo "joshcho/ChatGPT.el" :files ("dist" "*.el"))
  :init
  (require 'python)
  (setq chatgpt-repo-path "~/.emacs.d/straight/repos/ChatGPT.el/")
  :bind ("C-c q" . chatgpt-query))

; (use-package request
;   :straight t)

;; (use-package activity-watch-mode
;;   :straight t
;;   :after request
;;   :config (global-activity-watch-mode))

(use-package current-window-only
  :straight (:host github :repo "FrostyX/current-window-only")
  :bind (("C-c w" . current-window-only-mode)))

(use-package affe
  :straight t)

(provide 'ysz-utils)
;;; ysz-utils.el ends here
