;; start Emacs server
(server-start)

;; Transparency
(set-frame-parameter (selected-frame) 'alpha '(90 . 90))
(add-to-list 'default-frame-alist '(alpha . (90 . 90)))

;; Add these things to `default-frame-alist'.
(modify-all-frames-parameters '((width . 95)
				(height . 25)))

;; Whether to report native compilation warnings
(setq native-comp-async-report-warnings-errors t)

;; Whether to report byte compilation warnings
;; ignore byte-compile warnings
(setq byte-compile-warnings '(not nresolved
                                  free-vars
                                  callargs
                                  redefine
                                  obsolete
                                  noruntime
                                  cl-functions
                                  interactive-only
                                  ))

;; set auto-save file and backup file directories
(setq auto-save-file-name-transforms
      `((".*" ,(concat user-emacs-directory "auto-save/") t)))

(setq backup-directory-alist
      `(("." . ,(expand-file-name
                 (concat user-emacs-directory "backups")))))

;; Line numbers setup
(global-display-line-numbers-mode -1)
(dolist (modes '(prog-mode-hook
		 conf-mode-hook
		 ibuffer-mode-hook
		 diff-mode-hook
		 magit-diff-mode-hook
		 notmuch-message-mode-hook
		 notmuch-show-mode-hook))
  (add-hook modes (lambda () (display-line-numbers-mode 1))))

;; UI tweaks
(if (display-graphic-p)
    (progn
      (menu-bar-mode 1)
      (tool-bar-mode -1)
      (scroll-bar-mode -1)
      (tab-bar-mode -1)
      (tab-bar-history-mode -1)
      (fringe-mode nil)))

;; Recentf -- keep track of recently-visited files
(recentf-mode t)

;; Emacs 29 -- `pixel-scroll-precision-mode' for enhanced scrolling behaviour.
(if (fboundp 'pixel-scroll-precision-mode)
    (pixel-scroll-precision-mode t))

;; Setup `load-path'.
(dolist (path '("yaslam-lisp/essentials" "yaslam-lisp/utility-packages" "yaslam-lisp/theming-packages" "yaslam-lisp/random-packages" "yaslam-lisp/other-packages" "yaslam-lisp/load-path"))
  (add-to-list 'load-path (locate-user-emacs-file path)))

;; Setup the `HOME' variable when on Windows.
(if (or (eq system-type 'msdos)
	(eq system-type 'windows-nt))
    ;; FIXME:: Need to find a better way to set this.
    ;; NOTE:: Windows doesn't use `HOME'.
    (setenv "HOME" (getenv "APPDATA")))

;; Setup MELPA
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(all-the-icons-default-adjust -0.2)
 '(all-the-icons-default-alltheicon-adjust 0.0)
 '(auth-source-save-behavior nil)
 '(custom-safe-themes
   '("7f954d5bee47a27cc6cc83d1d6b80f7a32d82f744a725375d6e22b65758f9a5e" "3eb4031719479655814b5db031492570cdc7c82e37f34d7707515590c926980f" "06a2eef27703cd3c8b017c90d9025d766ade307971826362c487a5273e14cc5a" "830877f4aab227556548dc0a28bf395d0abe0e3a0ab95455731c9ea5ab5fe4e1" "631c52620e2953e744f2b56d102eae503017047fb43d65ce028e88ef5846ea3b" "43b78a08f245bc198dadf35b324f445472c92dda3f1b6d1746cefee9f2ade177" "92cfd42cedb42fdd3ea0d84d518825a94f29b30be20f65978dab7d7c8fa30c6a" "b8720a6ec85bee63542f0b202763e0a40606863e9ca7ebd94b7fcd7744234312" "e3daa8f18440301f3e54f2093fe15f4fe951986a8628e98dcd781efbec7a46f2" "443e2c3c4dd44510f0ea8247b438e834188dc1c6fb80785d83ad3628eadf9294" "2078837f21ac3b0cc84167306fa1058e3199bbd12b6d5b56e3777a4125ff6851" "adaf421037f4ae6725aa9f5654a2ed49e2cd2765f71e19a7d26a454491b486eb" "aec7b55f2a13307a55517fdf08438863d694550565dee23181d2ebd973ebd6b8" "7a424478cb77a96af2c0f50cfb4e2a88647b3ccca225f8c650ed45b7f50d9525" "636b135e4b7c86ac41375da39ade929e2bd6439de8901f53f88fde7dd5ac3561" "0c08a5c3c2a72e3ca806a29302ef942335292a80c2934c1123e8c732bb2ddd77" "4c56af497ddf0e30f65a7232a8ee21b3d62a8c332c6b268c81e9ea99b11da0d3" "51c71bb27bdab69b505d9bf71c99864051b37ac3de531d91fdad1598ad247138" "a44e2d1636a0114c5e407a748841f6723ed442dc3a0ed086542dc71b92a87aee" "8d3ef5ff6273f2a552152c7febc40eabca26bae05bd12bc85062e2dc224cde9a" "02f57ef0a20b7f61adce51445b68b2a7e832648ce2e7efb19d217b6454c1b644" "e87f48ec4aebdca07bb865b90088eb28ae4b286ee8473aadb39213d361d0c45f" "b69d8a1a142cde4bbde2f940ac59d2148e987cd235d13d6c4f412934978da8ab" "046e442b73846ae114d575a51be9edb081a1ef29c05ae5e237d5769ecfd70c2e" "af27beda94a2088d5f97c9bcb2bf08a1ede9b4f9562c1b1259ca171fce7d0838" "f33f145b036bc630b5a7e2a3100fd38c4220699347e32283a74489b19c36c84b" "0c2d7f410f835d59a0293f2a55744e9d3be13aab8753705c6ad4a9a968fb3b28" "9ac7d7994276098c96854480c123aaea66e059a23148dd0a80024f91a1db94f6" "5595d75552f01ea5cf48cf21cab93793362d71b69ad6ce4ab1662506183b16b5" "22eef4c1484c8caf5dad32054830080e76f2076ec8e6b950b3f0b70ba5c988fe" "6fad1050fbe7ee0b4bca65d33078d279a96f64c0df3286b36ce45fe4803847f2" "68a665225842bc1dec619da72f6d2e05d5c46fc64a70199272ebc21cab74477f" "f1a116f53d9e685023ebf435c80a2fecf11a1ecc54bb0d540bda1f5e2ae0ae58" "857a606b0b1886318fe4567cc073fcb1c3556d94d101356da105a4e993112dc8" "289474b5a9be8e9aad6b217b348f69af6d9c6e86a17c271ab4f5b67d13cf2322" "ff1607d931035f2496e58566ee567b44a0f10be2f3f55d8e2956af16a2431d94" "a76e034a8724a5d3247ed0cd76875e7d42755fbd90b99569ffebc6a4020d9b65" "4a288765be220b99defaaeb4c915ed783a9916e3e08f33278bf5ff56e49cbc73" default))
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
 '(package-selected-packages
   '(yaml-mode pcmpl-args notmuch-bookmarks xah-fly-keys corfu-terminal corfu-doc kind-icon cape all-the-icons-completion mct meow evil-collection consult-imenu flx-isearch minions avy posframe diredfl fussy mini-frame readline-complete company-shell company evil-multiedit org-contacts evil-smartparens evil-org evil-mc evil crux dashboard denote org-tree-slide solarized-theme solaire-mode doom-modeline doom-themes elfeed wgrep wgrep-ag deft ef-themes consult-eglot eglot osm org-modern notmuch-labeler highlight-indentation electric-cursor cursory all-the-icons-ibuffer diff-hl all-the-icons-dired all-the-icons ligature tempel consult-notmuch lin notmuch multiple-cursors iedit magit helpful ctrlf aggressive-indent marginalia consult pass embark which-key markdown-mode corfu sly vterm orderless smartparens))
 '(send-mail-function 'smtpmail-send-it)
 '(smtpmail-smtp-server "smtp-mail.outlook.com")
 '(smtpmail-smtp-service 25))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Emacs 29 introduced the new `keymap-set' function to set
;; keybinds, I moved my config over to it, since previous
;; Emacs versions do not have this new function yet, I made
;; a macro to emulate the functionality.
(unless (fboundp 'keymap-set)
  (defmacro keymap-set (map key func)
    `(define-key ,map (kbd ,key) ,func)))

(defmacro gkey (key func)
  "Define keys globally using a macro."
  `(keymap-set global-map ,key ,func))

(load-library "s")
(require 's)
(defmacro gremap (map func remap)
  "Remap keys using a macro.
- MAP is the map to remap the key on.
- FUNC is the function that you want to remap in string form, e.g: \"ibuffer\".
- REMAP is the function you want to remap to, can be nil
  (to remap to nothing, disabling the key for the function)
  or a function to remap to."
  (let ((rfunc (eval (concat "<remap> " (s-wrap func "<" ">")))))
    `(keymap-set ,map ,rfunc ,remap)))

(require 'emacs-essentials)
(require 'mode-line-customization)
(require 'misc-customizations)
(require 'erc-customizations)
(require 'theming-setup-modus)
;; (require 'theming-setup-ef)
;; (require 'theming-setup-minimal)
;; (require 'theming-setup-doom)
;; (require 'theming-setup-solarized)

(require 'fontaine-setup)
(require 'cursory-setup)
(require 'electric-cursor-setup)
(require 'diff-hl-setup)
(require 'kind-icon-setup)
;; (require 'all-the-icons-completion-setup)
(require 'all-the-icons-ibuffer-setup)
(require 'all-the-icons-dired-setup)
(require 'zen-mode-setup) ; USE zen-mode fetched through git and put in load-path
(require 'tempel-setup)
(require 'lin-setup)
(require 'notmuch-setup)
(require 'pulsar-setup)
;; (require 'multiple-cursors-setup)
(require 'iedit-setup)
(require 'org-setup)
;; (require 'org-modern-setup)
(require 'org-contacts-setup)
(require 'magit-setup)
(require 'helpful-setup)
;; (require 'ctrlf-setup)
(require 'aggressive-indent-setup)
(require 'marginalia-setup)
(require 'consult-setup)
(require 'embark-setup)
;; (require 'which-key-setup)
(require 'orderless-setup)
;; (require 'fussy-setup) ; trying out fussy completion style instead of orderless completion style
(require 'cape-setup)
(require 'corfu-setup)
;; (require 'company-setup)
;; (require 'smartparens-setup)
;; (require 'minimal-completion)
;; (require 'mct-setup)
(require 'vertico-setup) ; USE vertico fetched through git and put in load-path, ERROR: buffer-local-value is obsolete
(require 'eglot-setup)
(require 'deft-setup)
(require 'elfeed-setup)
;; (require 'doom-modeline-setup)
;; (require 'powerline-setup) ; USE powerline fetched through git and put in load-path
;; (require 'solaire-setup)
;; (require 'evil-setup)
;; (require 'xah-fly-keys-setup)
;; (require 'meow-setup)
(require 'denote-setup)
;; (require 'dashboard-setup)
;; (require 'mini-frame-setup)
(require 'diredfl-setup)
(require 'avy-setup)
;; (require 'minions-setup)
;; (require 'flx-isearch-setup)
(require 'meme-setup)
(require 'notmuch-indicator-setup)
(require 'elisp-format-setup)
(require 'web-mode-setup)
(require 'yaml-mode-setup)
(require 'exwm-setup)
(require 'kbd-mode-setup)
(require 'app-launcher-setup)
