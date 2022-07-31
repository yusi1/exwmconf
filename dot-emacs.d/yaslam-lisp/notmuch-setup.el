(require 'notmuch)

(defun notmuch-update-maildir ()
  "Call `notmuch new` to update maildir."
  (interactive)
  (if 
      (shell-command "notmuch new" "*maildir-update*" "*maildir-update-errors*")
      (switch-to-buffer "*maildir-update*")
    (switch-to-buffer "*maildir-update-errors*")))

(let ((map global-map))
  (define-key global-map (kbd "C-c e e") 'notmuch)
  (define-key global-map (kbd "C-c e u") 'notmuch-update-maildir))

(setq mail-host-address "YUZi54780@outlook.com")
(setq user-full-name "Yusef Aslam")
(setq user-mail-adress "YUZi54780@outlook.com")
(setq mail-user-agent 'message-user-agent)
(setq message-kill-buffer-on-exit t)
(setq notmuch-fcc-dirs "sent")

(provide 'notmuch-setup)
