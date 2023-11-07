;;; Email configurations (notmuch et al.) --- ysz-email.el

;; (use-package general
;;   :straight t)

;; (use-package notmuch
;;   :straight t
;;   :config
;;   (defun notmuch-update-maildir ()
;;     "Call `notmuch new` to update maildir."
;;     (interactive)
;;     (let ((name "maildir-update")
;; 	  (buffer "*maildir-update*"))
;;       (make-process
;;        :name name
;;        :buffer buffer
;;        :command '("notmuch"
;; 		  "new"))
;;       ))
;;   (defun display-maildir-update-buffer ()
;;     "Display the maildir update buffer."
;;     (interactive)
;;     (when (notmuch-update-maildir)
;;       (let ((buffer "*maildir-update*"))
;; 	(if (get-buffer buffer)
;;             (display-buffer buffer `((display-buffer-in-side-window)
;; 				     (side . bottom)
;; 				     (window-height . 10)))))))
;;   (defun fetch-mail ()
;;     "Call `getmail --rcfile personal -v` to fetch new emails."
;;     (interactive)
;;     (let ((name "fetch-mail")
;; 	  (buffer "*fetch-mail-status*"))
;;       (make-process
;;        :name name
;;        :buffer buffer
;;        :command '("/usr/bin/getmail"
;; 		  "--rcfile" "personal"
;; 		  "-v"))
;;       (display-buffer buffer)))
;;   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;   (general-def notmuch-hello-mode-map
;;     "C-c C-u" 'display-maildir-update-buffer)
;;   (general-def global-map
;;     :prefix "C-c e"
;;     "e" 'notmuch
;;     "u" 'notmuch-update-maildir)
;;   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;   (add-hook 'notmuch-hello-refresh-hook 'notmuch-update-maildir)
;;   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;   (setq mail-host-address "YUZi54780@outlook.com")
;;   (setq user-full-name "Yusef Aslam")
;;   (setq user-mail-address "YUZi54780@outlook.com")
;;   (setq mail-user-agent 'message-user-agent)
;;   (setq message-kill-buffer-on-exit t)
;;   (setq notmuch-fcc-dirs "sent")
;;   (setq notmuch-show-logo nil))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (use-package notmuch-bookmarks
;;   :after (notmuch)
;;   :straight t
;;   :config
;;   (notmuch-bookmarks-mode))
;; (use-package consult-notmuch
;;   :after (consult)
;;   :straight t
;;   :config
;;   (add-to-list 'consult-buffer-sources (quote
;; 					consult-notmuch-buffer-source)))

(provide 'ysz-email)
;;; ysz-email.el ends here
