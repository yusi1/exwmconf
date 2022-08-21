(require 'notmuch)
(require 'notmuch-labeler)

(defun notmuch-update-maildir ()
  "Call `notmuch new` to update maildir."
  (interactive)
  (let ((name "maildir-update")
	(buffer "*maildir-update*"))
    (make-process
     :name name
     :buffer buffer
     :command '("/usr/local/bin/notmuch"
		"new"))
    (display-buffer buffer)))

(defun fetch-mail ()
  "Call `getmail --rcfile personal -v` to fetch new emails."
  (interactive)
  (let ((name "fetch-mail")
	(buffer "*fetch-mail-status*"))
    (make-process
     :name name
     :buffer buffer
     :command '("/usr/bin/getmail"
		"--rcfile" "personal"
		"-v"))
    (display-buffer buffer)))

(let ((map global-map))
  (define-key global-map (kbd "C-c e e") 'notmuch)
  (define-key global-map (kbd "C-c e u") 'notmuch-update-maildir))

(setq mail-host-address "YUZi54780@outlook.com")
(setq user-full-name "Yusef Aslam")
(setq user-mail-adress "YUZi54780@outlook.com")
(setq mail-user-agent 'message-user-agent)
(setq message-kill-buffer-on-exit t)
(setq notmuch-fcc-dirs "sent")
(setq notmuch-show-logo nil)

;; `notmuch-labeler' setup.
(notmuch-labeler-rename "unread" "unread" ':foreground "aqua")
(notmuch-labeler-rename "inbox" "inbox" ':foreground "green")
(notmuch-labeler-rename "signed" "signed" ':foreground "pink")
(notmuch-labeler-rename "urgent" "urgent" ':foreground "red")
(notmuch-labeler-rename "read" "read" ':foreground "green")

(provide 'notmuch-setup)
