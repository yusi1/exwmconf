(require 'notmuch)

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

(progn
  (gkey "C-c e e" 'notmuch)
  (gkey "C-c e u" 'notmuch-update-maildir))

(setq mail-host-address "YUZi54780@outlook.com")
(setq user-full-name "Yusef Aslam")
(setq user-mail-adress "YUZi54780@outlook.com")
(setq mail-user-agent 'message-user-agent)
(setq message-kill-buffer-on-exit t)
(setq notmuch-fcc-dirs "sent")
(setq notmuch-show-logo nil)

;; Add things to show in `notmuch-hello'.
(setq notmuch-saved-searches
      `((:name "all mail" :query "*" :key ,(kbd "a"))
	(:name "inbox" :query "tag:inbox" :key ,(kbd "i"))
	(:name "unread" :query "tag:unread" :key ,(kbd "u"))
	(:name "flagged" :query "tag:flagged" :key ,(kbd "f"))
	(:name "sent" :query "tag:sent" :key ,(kbd "t"))
	(:name "drafts" :query "tag:draft" :key ,(kbd "d"))
	(:name "urgent" :query "tag:urgent" :key ,(kbd "!"))
	(:name "noip" :query "tag:noip" :key ,(kbd "ni"))
	(:name "redhat" :query "tag:redhat" :key ,(kbd "rh"))))

(provide 'notmuch-setup)
