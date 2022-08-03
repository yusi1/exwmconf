;; Line numbers setup
(global-display-line-numbers-mode)

;; Setup `load-path'.
(dolist (path '("yaslam-lisp"))
  (add-to-list 'load-path (locate-user-emacs-file path)))

;; Setup MELPA
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auth-source-save-behavior nil)
 '(custom-safe-themes
   '("4a288765be220b99defaaeb4c915ed783a9916e3e08f33278bf5ff56e49cbc73" default))
 '(notmuch-search-oldest-first nil)
 '(package-selected-packages
   '(tempel consult-notmuch lin notmuch pulsar multiple-cursors wgrep iedit org-superstar magit helpful ctrlf aggressive-indent marginalia consult pass embark which-key markdown-mode corfu sly vterm orderless vertico smartparens))
 '(smtpmail-smtp-server "smtp-mail.outlook.com")
 '(smtpmail-smtp-service 25))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'emacs-essentials)

(require 'fontaine-setup)
(require 'tempel-setup)
(require 'lin-setup)
(require 'notmuch-setup)
(require 'pulsar-setup)
(require 'multiple-cursors-setup)
(require 'iedit-setup)
(require 'org-setup)
(require 'magit-setup)
(require 'helpful-setup)
(require 'ctrlf-setup)
(require 'aggressive-indent-setup)
(require 'marginalia-setup)
(require 'consult-setup)
(require 'embark-setup)
(require 'which-key-setup)
(require 'orderless-setup)
(require 'corfu-setup)
(require 'smartparens-setup)
(require 'vertico-setup)
(require 'theming-setup)
