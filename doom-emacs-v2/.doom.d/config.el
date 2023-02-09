;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Yusef Aslam"
      user-mail-address "YUZi54780@outlook.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; load path additions
(add-load-path! "site-lisp")

;; support killed text going to the system clipboard
(require 'osc52)

(use-package! erc
  :config
  ;; Use authinfo instead of prompting for passwords.
  (setq erc-prompt-for-password nil)
  ;; Use NickServ to authenticate.
  (setq erc-use-auth-source-for-nickserv-password t)

  ;;; DONE:: [2023-01-22 Sun 01:53]
  ;; Fixed: The problem was that ZNC
  ;;        needed to run on SSL mode on
  ;;        the computer that hosts it for
  ;;        me to be able to connect to it using TLS.
  ;; ZNC expects the client identifier and
  ;; password in the USERNAME field and not
  ;; the NICK field.
  (defun znc-connect-tls ()
   (interactive)
   (erc-tls :server "freebsd-oldman.home" :port 3000 :nick "zncadmin" :user "zncadmin@laptop-emacs/libera" :password "ZNCIRC43521.")))


(use-package! znc
  :config
  (require 'znc)
  (setq znc-servers '(("freebsd-oldman.home" 3000 t
                       ((libera "zncadmin@laptop-emacs" "ZNCIRC43521."))))))

(after! mu4e
  ;; support IMAP IDLE -- this checks for a file in /tmp
  ;; if that file exists mu4e is refreshed.
  (require 'mu4e-IDLE-check)

  ;; Each path is relative to the path of the maildir you passed to mu
  (set-email-account! "gmail"
          '((mu4e-sent-folder       . "/gmail/[Gmail]/Sent Mail")
            (mu4e-drafts-folder     . "/gmail/[Gmail]/Drafts")
            (mu4e-trash-folder      . "/gmail/[Gmail]/Bin")
            (mu4e-refile-folder     . "/gmail/INBOX")
            (user-mail-address      . "yaslam0x1@gmail.com")    ;; only needed for mu < 1.4
            (smtpmail-smtp-user     . "yaslam0x1@gmail.com")
            (smtpmail-smtp-service  . "587")
            (mu4e-compose-signature . "---\nRegards\nYusef Aslam"))
           t)

  (set-email-account! "outlook"
          '((mu4e-sent-folder       . "/outlook/Sent")
            (mu4e-drafts-folder     . "/outlook/Drafts")
            (mu4e-trash-folder      . "/outlook/Deleted")
            (mu4e-refile-folder     . "/outlook/Inbox")
            (user-mail-address      . "YUZi54780@outlook.com")    ;; only needed for mu < 1.4
            (smtpmail-smtp-user     . "YUZi54780@outlook.com")
            (smtpmail-smtp-service  . "587")
            (mu4e-compose-signature . "---\nRegards\nYusef Aslam"))
          t)

  (setq mu4e-context-policy 'ask-if-none
        mu4e-compose-context-policy 'always-ask)

  ;; if "gmail" is missing from the address or maildir, the account must be listed here
  (setq +mu4e-gmail-accounts '(("yaslam0x1@gmail.com" "/gmail")))

  ;; auto fetch mail every N seconds
  (setq mu4e-update-interval 60)
  ;; (setq mu4e-update-interval nil)

  ;; don't need to run cleanup after indexing for gmail
  (setq mu4e-index-cleanup nil)
  ;; because gmail uses labels as folders we can use lazy check since
  ;; messages don't really "move"
  (setq mu4e-index-lazy-check t)

  ;; before retrieving and updating the mail, update the mail index nonlazily to catch
  ;; changes that were missed because of lazy checking
  (add-hook! 'mu4e-update-pre-hook 'mu4e-update-index-nonlazy))

;; (use-package! prodigy
;;   :init (prodigy-define-tag
;;           :name 'email
;;           :ready-message "Checking Email using IMAP IDLE. Ctrl-C to shutdown.")
;;   :config
;;   (prodigy-define-service
;;     :name "goimapnotify-gmail"
;;     :command "goimapnotify"
;;     :args (list "-conf" (expand-file-name ".config/imapnotify/imapnotify-gmail.conf" (getenv "HOME")))
;;     :tags '(email)
;;     :kill-signal 'sigkill)
;;   (prodigy-define-service
;;     :name "goimapnotify-outlook"
;;     :command "goimapnotify"
;;     :args (list "-conf" (expand-file-name ".config/imapnotify/imapnotify-outlook.conf" (getenv "HOME")))
;;     :tags '(email)
;;     :kill-signal 'sigkill))
