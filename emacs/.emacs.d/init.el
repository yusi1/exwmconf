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

;; Emacs 29 -- `pixel-scroll-precision-mode' for enhanced scrolling behaviour.
(pixel-scroll-precision-mode t)

;; Setup `load-path'.
(dolist (path '("yaslam-lisp/essentials" "yaslam-lisp/utility-packages" "yaslam-lisp/theming-packages"))
  (add-to-list 'load-path (locate-user-emacs-file path)))

;; Setup the `HOME' variable for the laptop.
(if (string-match-p (system-name) "IDEAPAD-120S-14")
    (setenv "HOME" "C:\\Users\\YUZi5\\AppData\\Roaming"))

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
   '("b69d8a1a142cde4bbde2f940ac59d2148e987cd235d13d6c4f412934978da8ab" "046e442b73846ae114d575a51be9edb081a1ef29c05ae5e237d5769ecfd70c2e" "af27beda94a2088d5f97c9bcb2bf08a1ede9b4f9562c1b1259ca171fce7d0838" "f33f145b036bc630b5a7e2a3100fd38c4220699347e32283a74489b19c36c84b" "0c2d7f410f835d59a0293f2a55744e9d3be13aab8753705c6ad4a9a968fb3b28" "9ac7d7994276098c96854480c123aaea66e059a23148dd0a80024f91a1db94f6" "5595d75552f01ea5cf48cf21cab93793362d71b69ad6ce4ab1662506183b16b5" "22eef4c1484c8caf5dad32054830080e76f2076ec8e6b950b3f0b70ba5c988fe" "6fad1050fbe7ee0b4bca65d33078d279a96f64c0df3286b36ce45fe4803847f2" "68a665225842bc1dec619da72f6d2e05d5c46fc64a70199272ebc21cab74477f" "f1a116f53d9e685023ebf435c80a2fecf11a1ecc54bb0d540bda1f5e2ae0ae58" "857a606b0b1886318fe4567cc073fcb1c3556d94d101356da105a4e993112dc8" "289474b5a9be8e9aad6b217b348f69af6d9c6e86a17c271ab4f5b67d13cf2322" "ff1607d931035f2496e58566ee567b44a0f10be2f3f55d8e2956af16a2431d94" "a76e034a8724a5d3247ed0cd76875e7d42755fbd90b99569ffebc6a4020d9b65" "4a288765be220b99defaaeb4c915ed783a9916e3e08f33278bf5ff56e49cbc73" default))
 '(notmuch-search-oldest-first nil)
 '(package-selected-packages
   '(ef-themes consult-eglot eglot osm org-modern-indent org-modern notmuch-labeler highlight-indentation electric-cursor cursory all-the-icons-ibuffer diff-hl all-the-icons-dired all-the-icons ligature tempel consult-notmuch lin notmuch multiple-cursors wgrep iedit magit helpful ctrlf aggressive-indent marginalia consult pass embark which-key markdown-mode corfu sly vterm orderless vertico smartparens))
 '(send-mail-function 'smtpmail-send-it)
 '(smtpmail-smtp-server "smtp-mail.outlook.com")
 '(smtpmail-smtp-service 25))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

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

(require 'fontaine-setup)
(require 'cursory-setup)
(require 'electric-cursor-setup)
(require 'diff-hl-setup)
(require 'all-the-icons-ibuffer-setup)
(require 'all-the-icons-dired-setup)
(require 'zen-mode-setup)
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
;; (require 'minimal-completion)
(require 'vertico-setup)
(require 'eglot-setup)
