(require 'notmuch-indicator)

(setq notmuch-indicator-args '((:terms "date:today and tag:personal and tag:unread and tag:inbox and not tag:redhat and not tag:emacs-devel and not tag:emacs-bugs and not tag:noip and not tag:debian" :label "PE@")
			       (:terms "tag:noip and date:today" :label "NI@")
			       (:terms "tag:emacs-devel and date:today" :label "ED@")
			       (:terms "tag:emacs-bugs and date:today" :label "EB@")))

(setq notmuch-indicator-hide-empty-counters t)
(notmuch-indicator-mode t)

(provide 'notmuch-indicator-setup)
