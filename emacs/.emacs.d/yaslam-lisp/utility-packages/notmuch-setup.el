(require 'notmuch)
(require 'notmuch-bookmarks)

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
    ))

(defun display-maildir-update-buffer ()
  "Display the maildir update buffer."
  (interactive)
  (when (notmuch-update-maildir)
    (let ((buffer "*maildir-update*"))
      (if (get-buffer buffer)
          (display-buffer buffer `((display-buffer-in-side-window)
				   (side . bottom)
				   (window-height . 10)))))))

(keymap-set notmuch-hello-mode-map "C-c C-u" 'display-maildir-update-buffer)
(add-hook 'notmuch-hello-refresh-hook 'notmuch-update-maildir)

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
	(:name "personal-inbox" :query "tag:inbox and tag:personal and not tag:redhat and not tag:emacs-devel and not tag:emacs-bugs and not tag:debian" :key ,(kbd "i"))
	(:name "other-inbox" :query "tag:inbox and tag:other" :key ,(kbd "oi"))
	(:name "unread" :query "tag:unread" :key ,(kbd "u"))
	(:name "flagged" :query "tag:flagged" :key ,(kbd "f"))
	(:name "sent" :query "tag:sent" :key ,(kbd "t"))
	(:name "drafts" :query "tag:draft" :key ,(kbd "dr"))
	(:name "urgent" :query "tag:urgent" :key ,(kbd "!"))
	(:name "noip" :query "tag:noip" :key ,(kbd "ni"))
	(:name "redhat" :query "tag:redhat" :key ,(kbd "rh"))
	(:name "debian" :query "tag:debian" :key ,(kbd "db"))
	(:name "emacs-devel" :query "tag:emacs-devel" :key ,(kbd "ed"))
	(:name "emacs-bugs" :query "tag:emacs-bugs" :key ,(kbd "eb"))))

;; minor mode to add Emacs standard bookmark functionality to `notmuch'
(notmuch-bookmarks-mode)

(provide 'notmuch-setup)
