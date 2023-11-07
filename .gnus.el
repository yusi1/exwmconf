(setq user-mail-address "YUZi54780@outlook.com"
      user-full-name "Yusef Aslam")

(setq gnus-select-method
      '(nnnil nil))

(setq gnus-secondary-select-methods
      '((nnimap "outlook-personal"
		(nnimap-address "imap-mail.outlook.com")
		(nnimap-server-port "imaps")
		(nnimap-stream ssl)
		(nnir-search-engine imap)
		(nnmail-expiry-target "nnimap+outlook-personal:Deleted")
		(nnmail-expiry-wait 'immediate))
	(nnimap "gmail-personal"
		(nnimap-address "imap.gmail.com")
		(nnimap-server-port "imaps")
		(nnimap-stream ssl)
		(nnir-search-engine imap)
		(nnmail-expiry-target "nnimap+gmail-personal:[Gmail]/Trash")
		(nnmail-expiry-wait 'immediate))))

;; (add-to-list 'gnus-secondary-select-methods
;; 	     '(nnml ""))

(setq mail-sources
      '((file :path "/var/mail/yaslam")))

(setq nnmail-split-incoming t)

(setq nnmail-split-methods
      '(("MADMAN" "From:.*Moritz Muehlenhoff")
	("Debbugs" "To:.*debian-security-announce@lists.debian.org")
	("mail.misc" "")))

(setq nnimap-split-methods 'default)

;; Reply to mails with matching email address
(setq gnus-posting-styles
      '((".*" ; Matches all groups of messages
         (address "Yusef Aslam <YUZi54780@outlook.com>"))
        ("gmail-personal" ; Matches Gnus group called "gmail-personal"
         (address "Yusef Aslam <yaslam0x1@gmail.com>")
         ("X-Message-SMTP-Method" "smtp smtp.gmail.com 587 yaslam0x1@gmail.com"))))

;; (setq send-mail-function 'smtpmail-send-it
;;       message-send-mail-function 'smtpmail-send-it
;;       smtpmail-smtp-server "smtp-mail.outlook.com"
;;       smtpmail-smtp-service 587)

;; Attempt to encrypt all the mails we'll be sending.
;; (add-hook 'message-setup-hook 'mml-secure-message-encrypt)

;;format=flowed
;; https://www.emacswiki.org/emacs/GnusFormatFlowed
(defun harden-newlines ()
  (save-excursion
    (goto-char (point-min))
    (while (search-forward "\n" nil t)
      (put-text-property (1- (point)) (point) 'hard t))))

(setq fill-flowed-display-column nil)

;; The following line is needed since emacs 24.1:
(setq gnus-treat-fill-long-lines nil)

(add-hook 'message-setup-hook
  (lambda ()
    (when message-this-is-mail
      (turn-off-auto-fill)
      (setq
	truncate-lines nil
	word-wrap t
	use-hard-newlines t))))

(add-hook 'message-send-hook
  (lambda ()
    (when use-hard-newlines
      (harden-newlines))))

(add-hook 'gnus-article-mode-hook
  (lambda ()
    (setq
      truncate-lines nil
      word-wrap t)))
