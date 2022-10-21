(use-package notmuch
  :straight t
  :config
  (keymap-set global-map "C-c e" 'notmuch)
  (setq mail-host-address "YUZi54780@outlook.com")
  (setq user-full-name "Yusef Aslam")
  (setq user-mail-adress "YUZi54780@outlook.com")
  (setq mail-user-agent 'message-user-agent)
  (setq message-kill-buffer-on-exit t)
  (setq notmuch-fcc-dirs "sent")
  (setq notmuch-show-logo nil))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package notmuch-bookmarks
  :after (notmuch)
  :straight t
  :config
  (notmuch-bookmarks-mode))
(use-package consult-notmuch
  :after (consult)
  :straight t
  :config
  (add-to-list 'consult-buffer-sources (quote
					consult-notmuch-buffer-source)))

(provide 'ysz-email)
