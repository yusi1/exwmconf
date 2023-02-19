;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Yusef Aslam"
      user-mail-address "YUZi54780@outlook.com")

(setq auth-sources '("~/.authinfo.gpg")
      auth-source-cache-expiry nil) ; default is 7200 (2h)

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

;; ui stuff
(delete-selection-mode 1)
(ffap-bindings)

;; load path additions
(let ((dir doom-user-dir))
  (add-to-list 'load-path (concat dir "lisp"))
  (add-to-list 'load-path (concat dir "lisp/ysz-addons/")))

;; my keybind addons
(require 'ysz-keybinds)

;; support killed text going to the system clipboard
(require 'osc52)

;; enhancements to info mode
(require 'info+)

;; get rid of org-agenda section in doom dashboard
(setq +doom-dashboard-menu-sections
      '(("Reload last session"
         :icon (all-the-icons-octicon "history" :face 'doom-dashboard-menu-title)
         :when (cond ((modulep! :ui workspaces)
                      (file-exists-p (expand-file-name persp-auto-save-fname persp-save-dir)))
                     ((require 'desktop nil t)
                      (file-exists-p (desktop-full-file-name))))
         :face (:inherit (doom-dashboard-menu-title bold))
         :action doom/quickload-session)
        ;; ("Open org-agenda"
        ;;  :icon (all-the-icons-octicon "calendar" :face 'doom-dashboard-menu-title)
        ;;  :when (fboundp 'org-agenda)
        ;;  :action org-agenda)
        ("Recently opened files"
         :icon (all-the-icons-octicon "file-text" :face 'doom-dashboard-menu-title)
         :action recentf-open-files)
        ("Open project"
         :icon (all-the-icons-octicon "briefcase" :face 'doom-dashboard-menu-title)
         :action projectile-switch-project)
        ("Jump to bookmark"
         :icon (all-the-icons-octicon "bookmark" :face 'doom-dashboard-menu-title)
         :action bookmark-jump)
        ("Open private configuration"
         :icon (all-the-icons-octicon "tools" :face 'doom-dashboard-menu-title)
         :when (file-directory-p doom-user-dir)
         :action doom/open-private-config)
        ("Open documentation"
         :icon (all-the-icons-octicon "book" :face 'doom-dashboard-menu-title)
         :action doom/help)))

(use-package! erc
  :config
  ;; Use authinfo instead of prompting for passwords.
  (setq erc-prompt-for-password nil)
  ;; Use NickServ to authenticate.
  (setq erc-use-auth-source-for-nickserv-password t)

  (add-to-list 'load-path "~/.doom.d/lisp/erc-image/")
  (require 'erc-image)
  ;; :load-path "~/.doom.d/lisp/erc-image"
  (add-to-list 'erc-modules 'image)
  (erc-update-modules)

  (require 'erc-imenu)
  (map! "C-c i" 'consult-imenu)

  ;; This is an example of how to make a new command.  Type "/uptime" to
  ;; use it.
  (defun erc-cmd-UPTIME (&rest ignore)
    "Display the uptime of the system, as well as some load-related
     stuff, to the current ERC buffer."
    (let ((uname-output
           (replace-regexp-in-string
            ", load average: " "] {Load average} ["
            ;; Collapse spaces, remove
            (replace-regexp-in-string
             " +" " "
             ;; Remove beginning and trailing whitespace
             (replace-regexp-in-string
              "^ +\\|[ \n]+$" ""
              (shell-command-to-string "uptime"))))))
      (erc-send-message
       (concat "{Uptime} [" uname-output "]"))))

  (defun erc-cmd-BASE (&rest str)
    "Encode the argument STR into base64, output it into the current buffer."
    (if str
         (let ((str `,(mapconcat 'identity str " ")))
              (encoded-strings (base64-encode-string (s-join " " str)))
              (erc-send-message encoded-strings))))

  (defun erc-cmd-BL (chan lines)
    "Request a backlog from the ZNC backlog module by sending a message to the ZNC backlog module.
LINES is the amount of backlog lines to request, if LINES is `nil', LINES is set to 20.
CHAN is the channel to request the backlog for, if `nil', it is the current channel."
    (let ((chan chan)
          (lines lines))
      (erc-send-input-line "*backlog" (concat chan " " lines))))

  (defun erc-cmd-LOGS (chan &rest query)
    "Request a logsearch from the ZNC logsearch module by sending a message to the ZNC logsearch module.
CHAN is the channel to request the logsearch for.
QUERY is the query to search for in the logs."
    (let ((chan chan)
          (query `,(mapconcat 'identity query " ")))
      (erc-send-input-line "*logsearch" (concat chan " " query))))

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


(use-package! mu4e
  :demand t
  :config
  ;; support IMAP IDLE -- this checks for a file in /tmp
  ;; if that file exists mu4e is refreshed.
  (require 'mu4e-IDLE-check)
  ;; add the mu4e-compose-from-mailto function
  ;; adds a function used by emacsclient to compose mail using mu4e
  (require 'mu4e-compose-from-mailto)

  ;; fill-column, some mailing lists need this
  (setq fill-column 72)

  ;; support format=flowed
  ;; mailing lists don't support this
  (require 'mu4e-format-flowed)

     ;; signature auto include
  (setq mu4e-compose-signature-auto-include t)

   ;; Each path is relative to the path of the maildir you passed to mu
  (set-email-account! "gmail"
          '((mu4e-sent-folder       . "/gmail/sent")
            (mu4e-drafts-folder     . "/gmail/drafts")
            (mu4e-trash-folder      . "/gmail/bin")
            (mu4e-refile-folder     . "/gmail/INBOX")
            (user-mail-address      . "yaslam0x1@gmail.com")    ;; only needed for mu < 1.4
            (smtpmail-smtp-user     . "yaslam0x1@gmail.com")
            (smtpmail-smtp-service  . "587")
            (smtpmail-smtp-server   . "smtp.gmail.com")
            (mu4e-compose-signature . "Regards\nYusef Aslam"))
            ;; (org-msg-signature      . "Regards\nYusef Aslam"))
           t)

  (set-email-account! "outlook"
          '((mu4e-sent-folder       . "/outlook/Sent")
            (mu4e-drafts-folder     . "/outlook/Drafts")
            (mu4e-trash-folder      . "/outlook/Deleted")
            (mu4e-refile-folder     . "/outlook/Inbox")
            (user-mail-address      . "YUZi54780@outlook.com")    ;; only needed for mu < 1.4
            (smtpmail-smtp-user     . "YUZi54780@outlook.com")
            (smtpmail-smtp-service  . "587")
            (smtpmail-smtp-server   . "smtp-mail.outlook.com")
            (mu4e-compose-signature . "Regards\nYusef Aslam"))
            ;; (org-msg-signature      . "Regards\nYusef Aslam"))
           t)

  (setq mu4e-maildir-shortcuts
    '(("/gmail/INBOX" . ?i)
      ("/gmail/drafts" . ?d)
      ("/gmail/sent" . ?s)
      ("/gmail/bin" . ?b)))

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

(use-package! hydra
  :config
  (let ((gmail-base-dir-inbox "/gmail/")
        (outlook-base-dir "/outlook/"))
   (defhydra my-mu4e-maildir-jump-outlook (:color blue)
     "[Outlook]"
     ("i" (mu4e~headers-jump-to-maildir (concat outlook-base-dir "Inbox")) "Inbox")
     ("d" (mu4e~headers-jump-to-maildir (concat outlook-base-dir "Drafts"))   "Drafts")
     ("D" (mu4e~headers-jump-to-maildir (concat outlook-base-dir "Deleted"))   "Deleted")
     ("s" (mu4e~headers-jump-to-maildir (concat outlook-base-dir "Sent"))   "Sent"))

   (defhydra my-mu4e-maildir-jump-gmail (:color blue)
     "[Gmail]"
     ("i" (mu4e~headers-jump-to-maildir (concat gmail-base-dir-inbox "INBOX")) "Inbox")
     ("d" (mu4e~headers-jump-to-maildir (concat gmail-base-dir-inbox "drafts")) "Drafts")
     ("s" (mu4e~headers-jump-to-maildir (concat gmail-base-dir-inbox "sent")) "Sent")
     ("b" (mu4e~headers-jump-to-maildir (concat gmail-base-dir-inbox "bin")) "Bin"))

   (defhydra my-mu4e-maildir-jump (:color blue)
     "maildir jump"
     ("g" (my-mu4e-maildir-jump-gmail/body) "[Gmail]")
     ("o" (my-mu4e-maildir-jump-outlook/body) "[Outlook]")))

  (evil-define-key 'normal mu4e-main-mode-map "O" (lambda! () (interactive) (my-mu4e-maildir-jump/body)))
  (evil-define-key 'normal mu4e-headers-mode-map "O" (lambda! () (interactive) (my-mu4e-maildir-jump/body))))

;; (use-package! mu4e-views
;;   :after mu4e
;;   :defer nil
;;   :bind (:map mu4e-headers-mode-map
;;          ("v" . mu4e-views-mu4e-select-view-msg-method) ;; select viewing method
;;          ("M-n" . mu4e-views-cursor-msg-view-window-down) ;; from headers window scroll the email view
;;          ("M-p" . mu4e-views-cursor-msg-view-window-up) ;; from headers window scroll the email view
;;          ("f" . mu4e-views-toggle-auto-view-selected-message) ;; toggle opening messages automatically when moving in the headers view
;;          ("i" . mu4e-views-mu4e-view-as-nonblocked-html)) ;; show currently selected email with all remote content

;;   :config
;;   ;; (setq mu4e-views-completion-method 'ivy) ;; use ivy for completion
;;   (setq mu4e-views-default-view-method "browser") ;; make xwidgets default
;;   (mu4e-views-mu4e-use-view-msg-method "browser") ;; select the default
;;   (setq mu4e-views-next-previous-message-behaviour 'stick-to-current-window) ;; when pressing n and p stay in the current window
;;   (setq mu4e-views-auto-view-selected-message t)) ;; automatically open messages when moving in the headers view

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

; (use-package! org-contacts
;   :config
;   (setq org-contacts-files '("~/Documents/contacts.org"))

;   (defvar ysz/my-contact-template `,(concat "* %(org-contacts-template-name)\n"
;                                             ":PROPERTIES:\n"
;                                             ":EMAIL: %(org-contacts-template-email)\n"
;                                             ":NUMBER: %?\n"
;                                             ":END:\n")
;     "My org-capture contact template.")

;   (dolist (templates `(("c" "Contact Parent")
;                        ("c1" "Contact (Family)" entry (file+headline "~/Documents/contacts.org" "Family")
;                         ,ysz/my-contact-template
;                         :empty-lines 1)
;                        ("c2" "Contact (Friends)" entry (file+headline "~/Documents/contacts.org" "Friends")
;                         ,ysz/my-contact-template
;                         :empty-lines 1)
;                        ("co" "Contact (Others)" entry (file+headline "~/Documents/contacts.org" "Others")
;                         ,ysz/my-contact-template
;                         :empty-lines 1)))
;       (add-to-list 'org-capture-templates templates)))

;;; FIXME: Cannot use because of problems with unpinning compat.
;; (use-package! tempel
;;   :config
;;   (add-hook!
;;    prog-mode-hook 'tempel-setup-capf
;;    text-mode-hook 'tempel-setup-capf)

;;   (map!
;;     "M-+" 'tempel-complete
;;     "M-*" 'tempel-insert
;;     :map tempel-map
;;     "TAB" 'tempel-next
;;     "<backtab>" 'tempel-previous)

;;   (setq tempel-path "~/.doom.d/templates.el")
;;   (setq tempel-trigger-prefix "!")
;;   (defun tempel-setup-capf ()
;;     (setq-local completion-at-point-functions
;;                 (cons #'tempel-expand
;;                       completion-at-point-functions)))

;;   ;; Optionally make the Tempel templates available to Abbrev,
;;   ;; either locally or globally. `expand-abbrev' is bound to C-x '.
;;   (add-hook! prog-mode-hook 'tempel-abbrev-mode)
;;   (global-tempel-abbrev-mode))

; (use-package! eaf
;   :load-path "~/.doom.d/lisp/emacs-application-framework/"
;   :init
;   :custom
;   (eaf-browser-continue-where-left-off t)
;   (eaf-browser-enable-adblocker t)
;   (browse-url-browser-function 'eaf-open-browser) ;; Make EAF Browser my default browser
;   :config
;   (defalias 'browse-web #'eaf-open-browser)

;   (require 'eaf-mail)

;   (require 'eaf-browser)
;   (when (display-graphic-p)
;     (require 'eaf-all-the-icons))

;   (require 'eaf-evil)
;   (define-key key-translation-map (kbd "SPC")
;     (lambda (prompt)
;       (if (derived-mode-p 'eaf-mode)
;           (pcase eaf--buffer-app-name
;             ("browser" (if  (string= (eaf-call-sync "call_function" eaf--buffer-id "is_focus") "True")
;                            (kbd "SPC")
;                          (kbd eaf-evil-leader-key)))
;             (_  (kbd "SPC")))
;         (kbd "SPC")))))

;;; eshell fixes
;; turn off company-mode in eshell buffers since it is slow
(add-hook! 'eshell-mode-hook (company-mode -1))
;; (add-hook 'eshell-mode-hook (lambda () (company-mode -1)))
;; bind `C-x C-f' to `find-file' instead of `company-files'
;; in eshell buffers
(add-hook! 'eshell-mode-hook
   (with-current-buffer (current-buffer)
           (when (derived-mode-p 'eshell-mode)
             (map! :map evil-insert-state-map
                     "C-x C-f" 'find-file))))
;; eshell-visual-commands -- open these commands in a term buffer
(setq eshell-visual-commands
       (quote
        ("/usr/local/bin/crontab" "vi" "screen" "top" "less" "more" "lynx" "ncftp" "pine" "tin" "trn" "elm" "tmux" "nano")))

(use-package! cape
  :demand t
  :config
  ;; Bind dedicated completion commands
  ;; Alternative prefix keys: C-c p, M-p, M-+, ...
  (map! :prefix "C-c ["
    "p" 'completion-at-point ;; capf
    "t" 'complete-tag        ;; etags
    "d" 'cape-dabbrev        ;; or dabbrev-completion
    "h" 'cape-history
    "f" 'cape-file
    "k" 'cape-keyword
    "s" 'cape-symbol
    "a" 'cape-abbrev
    "i" 'cape-ispell
    "l" 'cape-line
    "w" 'cape-dict
    "\\" 'cape-tex
    "_" 'cape-tex
    "^" 'cape-tex
    "&" 'cape-sgml
    "r" 'cape-rfc1345)

   ;; Add `completion-at-point-functions', used by `completion-at-point'.
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file))

;; (use-package! consult
;;   :after affe
;;   :config
;;   (defun affe-orderless-regexp-compiler (input _type _ignorecase)
;;     (setq input (orderless-pattern-compiler input))
;;     (cons input (lambda (str) (orderless--highlight input str))))
;;   (setq affe-regexp-compiler #'affe-orderless-regexp-compiler))

(use-package! centaur-tabs
  :init
  (setq centaur-tabs-enable-key-bindings t)
  (setq centaur-tabs-enable-ido-completion nil)
  :config
  ;; (centaur-tabs-group-by-projectile-project) ; group by this function
  (centaur-tabs-group-buffer-groups) ; or this
  (map! "C-c t" 'centaur-tabs-switch-group)
  (map! "s-1" (lambda () (interactive) (centaur-tabs-select-visible-tab)))
  (map! "s-2" (lambda () (interactive) (centaur-tabs-select-visible-tab)))
  (map! "s-3" (lambda () (interactive) (centaur-tabs-select-visible-tab)))
  (map! "s-4" (lambda () (interactive) (centaur-tabs-select-visible-tab)))
  ;; disable centaur-tabs in these modes
  (add-hook! 'mu4e-view-mode-hook 'centaur-tabs-local-mode)
  (add-hook! 'mu4e-compose-mode-hook 'centaur-tabs-local-mode)
  (use-package! ysz-tweaks)
  (centaur-tabs-mode 1))

(use-package! org
  :config (map! :map org-mode-map "C-c q" 'kill-this-buffer))

(use-package! flycheck
  :config (setq flycheck-check-syntax-automatically '(save mode-enable)))

(use-package! vertico-multiform
  :load-path "~/.emacs.d/.local/straight/repos/vertico/extensions/"
  :config
  (map! :map vertico-map
    "C-c M-V" 'vertico-multiform-vertical
    "C-c M-G" 'vertico-multiform-grid
    "C-c M-F" 'vertico-multiform-flat
    "C-c M-R" 'vertico-multiform-reverse
    "C-c M-U" 'vertico-multiform-unobtrusive)
  ;; (setq vertico-multiform-commands
  ;;       '((consult-imenu vertical)))
  ;;         (execute-extended-command flat)))
  (vertico-multiform-mode t))

;; (use-package! mu4e-dashboard
;;   :config
;;   (setq mu4e-dashboard-file "~/org/mu4e-dashboard.org"))
