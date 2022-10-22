(server-start)

(set-frame-parameter (selected-frame) 'alpha '(90 . 90))
(add-to-list 'default-frame-alist '(alpha . (90 . 90)))

(modify-all-frames-parameters '((width . 95)
				(height . 25)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(notmuch-saved-searches
   '((:name "all mail" :query "*" :key "a")
     (:name "personal-inbox" :query "tag:inbox and tag:personal and not tag:redhat and not tag:emacs-devel and not tag:emacs-bugs and not tag:debian" :key "i")
     (:name "other-inbox" :query "tag:inbox and tag:other" :key "oi")
     (:name "unread" :query "tag:unread" :key "u")
     (:name "flagged" :query "tag:flagged" :key "f")
     (:name "sent" :query "tag:sent" :key "t")
     (:name "drafts" :query "tag:draft" :key "dr")
     (:name "urgent" :query "tag:urgent" :key "!")
     (:name "noip" :query "tag:noip" :key "ni")
     (:name "redhat" :query "tag:redhat" :key "rh")
     (:name "debian" :query "tag:debian" :key "db")
     (:name "emacs-devel" :query "tag:emacs-devel" :key "ed")
     (:name "emacs-bugs" :query "tag:emacs-bugs" :key "eb")
     (:name "Rebecca Stoker - Careers Advisor" :query "rebecca.stoker@sds.co.uk")))
 '(notmuch-search-oldest-first nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(variable-pitch ((t (:family "Iosevka Aile")))))

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

;; Load the helper package for commands like `straight-x-clean-unused-repos'
(require 'straight-x)

;; enabled commands
(put 'downcase-region 'disabled nil)

(require 'ysz-theme)
(require 'ysz-completion)
(require 'ysz-git)
(require 'ysz-email)
(require 'ysz-keybinds)
(require 'ysz-writing)
(require 'ysz-lang)
(require 'ysz-functions)
(require 'ysz-shell)

;;;;;;;;;;;;;;;;;;;;;
(defun ysz/exwm-enabled (switch) "Dummy function")
(add-to-list 'command-switch-alist '("--use-exwm" . ysz/exwm-enabled))
(setq ysz/exwm-enabled-p
      (if (seq-contains command-line-args "--use-exwm") t))

(when ysz/exwm-enabled-p
  (require 'ysz-desktop))
