(server-start)

;; (set-frame-parameter (selected-frame) 'alpha '(90 . 90))
;; (add-to-list 'default-frame-alist '(alpha . (90 . 90)))

;; (modify-all-frames-parameters '((width . 95)
;; 				(height . 25)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("f64189544da6f16bab285747d04a92bd57c7e7813d8c24c30f382f087d460a33" "02f57ef0a20b7f61adce51445b68b2a7e832648ce2e7efb19d217b6454c1b644" "5f128efd37c6a87cd4ad8e8b7f2afaba425425524a68133ac0efd87291d05874" "930ebff784a26210a29eeb4513518ec06340fb2afb5863211385aca08b55d18c" default))
 '(notmuch-saved-searches
   '((:name "all mail" :query "*" :key
	    [97])
     (:name "personal-inbox" :query "tag:inbox and tag:personal and not tag:redhat and not tag:debian" :key
	    [105])
     (:name "other-inbox" :query "tag:inbox and tag:other" :key
	    [111 105])
     (:name "unread" :query "tag:unread" :key
	    [117])
     (:name "flagged" :query "tag:flagged" :key
	    [102])
     (:name "sent" :query "tag:sent" :key
	    [116])
     (:name "drafts" :query "tag:draft" :key
	    [100 114])
     (:name "urgent" :query "tag:urgent" :key
	    [33])
     (:name "noip" :query "tag:noip" :key
	    [110 105])
     (:name "redhat" :query "tag:redhat" :key
	    [114 104])
     (:name "debian" :query "tag:debian" :key
	    [100 98])
     (:name "Rebecca Stoker - Careers Advisor" :query "rebecca.stoker@sds.co.uk")
     (:name "Vicky Briggs - Bernardos Scotland" :query "from:Vicky Briggs")))
 '(notmuch-search-oldest-first nil)
 '(send-mail-function 'smtpmail-send-it)
 '(smtpmail-smtp-server "smtp-mail.outlook.com")
 '(smtpmail-smtp-service 25))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.

 '(default ((t (:height 160 :family "Terminus" :weight bold))))
 '(fixed-pitch ((t (:height 160 :family "Terminus" :weight bold))))
 '(variable-pitch ((t (:height 1.04 :family "Terminus" :weight bold))))

 )

;;; Packages

;; Bootstrap straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
      (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
        "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
        'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; Always use straight to install on systems other than Linux
(setq straight-use-package-by-default nil)

;; Use straight.el for use-package expressions
(straight-use-package 'use-package)

;; Enable imenu support for use-package expressions
(setq use-package-enable-imenu-support t)

;; Make use-package error debugging more helpful when
;; Emacs is launched with the option `--debug-init'.
(if init-file-debug
    (setq use-package-verbose t
          use-package-expand-minimally nil
          use-package-compute-statistics t
          debug-on-error t)
  (setq use-package-verbose nil
        use-package-expand-minimally t))

;; Load the helper package for commands like
;; `straight-x-clean-unused-repos'
(require 'straight-x)

;; enabled commands
(put 'downcase-region 'disabled nil)
(put 'emms-browser-delete-files 'disabled nil)

(use-package ysz-theme)
(use-package ysz-completion)
(use-package ysz-git)
(use-package ysz-email)
(use-package ysz-keybinds)
(use-package ysz-writing)
(use-package ysz-lang)
(use-package ysz-functions)
(use-package ysz-shell)
(use-package ysz-utils)
(use-package ysz-media)
(use-package ysz-irc)

;;; EXWM
(defun ysz/exwm-enabled (switch) "Dummy function")
(add-to-list 'command-switch-alist '("--use-exwm" . ysz/exwm-enabled))
(setq ysz/exwm-enabled-p
      (if (seq-contains command-line-args "--use-exwm") t))

(when ysz/exwm-enabled-p
  (use-package ysz-desktop-init)
  (use-package ysz-desktop))
