(server-start)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

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
 '(notmuch-search-oldest-first nil)
 '(package-selected-packages '(notmuch corfu-doc corfu magit exwm orderless vertico)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(put 'downcase-region 'disabled nil)

(defmacro prot-emacs-builtin-package (package &rest body)
  "Set up builtin PACKAGE with rest BODY.
PACKAGE is a quoted symbol, while BODY consists of balanced
expressions."
  (declare (indent 1))
  `(progn
     (unless (require ,package nil 'noerror)
       (display-warning 'prot-emacs
                        (format "Loading `%s' failed" ,package)
                        :warning))
     ,@body))

(defmacro prot-emacs-elpa-package (package &rest body)
  "Set up PACKAGE from an Elisp archive with rest BODY.
PACKAGE is a quoted symbol, while BODY consists of balanced
expressions.
Try to install the package if it is missing."
  (declare (indent 1))
  `(progn
     (when (not (package-installed-p ,package))
       (unless package-archive-contents
         (package-refresh-contents))
       (package-install ,package))
     (if (require ,package nil 'noerror)
         (progn ,@body)
       (display-warning 'prot-emacs
                        (format "Loading `%s' failed" ,package)
                        :warning))))

(defun ysz/enable-desktop ()
  (prot-emacs-builtin-package 'ysz-desktop
    (message "a")))

(add-to-list 'command-switch-alist '("--use-exwm" . ysz/enable-desktop))

(prot-emacs-elpa-package 'orderless
  (setq completion-styles '(orderless basic)
	completion-category-defaults nil
	completion-category-overrides '((file (styles . (partial-completion))))))

(prot-emacs-elpa-package 'vertico
  (vertico-mode 1))

(prot-emacs-elpa-package 'corfu
  (let ((map corfu-map))
    (keymap-set map "M-p" 'nil)
    (keymap-set map "M-n" 'nil))
  (setq tab-always-indent 'complete)
  (setq completion-cycle-threshold 3)
  (global-corfu-mode 1))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(prot-emacs-elpa-package 'corfu-doc
  (let ((map corfu-map))
    (keymap-set map "M-p" 'corfu-doc-scroll-down)
    (keymap-set map "M-n" 'corfu-doc-scroll-up)
    (keymap-set map "M-d" 'corfu-doc-toggle))
  (corfu-doc-mode 1))

(prot-emacs-elpa-package 'magit
  (keymap-set global-map "C-x g" 'magit))

(prot-emacs-elpa-package 'notmuch
  (keymap-set global-map "C-c e" 'notmuch)
  (setq mail-host-address "YUZi54780@outlook.com")
  (setq user-full-name "Yusef Aslam")
  (setq user-mail-adress "YUZi54780@outlook.com")
  (setq mail-user-agent 'message-user-agent)
  (setq message-kill-buffer-on-exit t)
  (setq notmuch-fcc-dirs "sent")
  (setq notmuch-show-logo nil))


