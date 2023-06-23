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
(setq doom-font "Fira Code-12")
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
(add-to-list 'default-frame-alist '(internal-border-width . 10))
;; (map! "<f12>" 'modus-themes-toggle)

;; fish shell completions
(when (and (executable-find "fish")
           (require 'fish-completion nil t))
  (global-fish-completion-mode))

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

(after! erc
  ;; Use authinfo instead of prompting for passwords.
  (setq erc-prompt-for-password nil)
  ;; Use NickServ to authenticate.
  (setq erc-use-auth-source-for-nickserv-password t)

  (add-to-list 'load-path "~/.doom.d/lisp/erc-image/")
  ;; (require 'erc-image)
  ;; ;; :load-path "~/.doom.d/lisp/erc-image"
  ;; (add-to-list 'erc-modules 'image)
  ;; (erc-update-modules)

  ;; (require 'erc-imenu)
  ;; (map! "C-c i" 'consult-imenu)

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


(after! znc
  (require 'znc)
  (setq znc-servers '(("freebsd-oldman.home" 3000 t
                       ((libera "zncadmin@laptop-emacs" "ZNCIRC43521."))))))

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
  :config
  ;; Bind dedicated completion commands
  ;; Alternative prefix keys: C-c p, M-p, M-+, ...
  (map! :g :prefix "C-c ["
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

(after! (:and org org-superstar)
  (map! :map org-mode-map "C-c q" 'kill-this-buffer)

  (dolist (face '((org-level-1 . 1.2)
                  (org-level-2 . 1.1)
                  (org-level-3 . 1.05)
                  (org-level-4 . 1.0)
                  (org-level-5 . 1.1)
                  (org-level-6 . 1.1)
                  (org-level-7 . 1.1)
                  (org-level-8 . 1.1)))
    (set-face-attribute (car face) nil :font "Fira Code" :weight 'bold :height (cdr face)))

  (setq org-publish-project-alist
      '(("yaslam's website" ;; my blog project (just a name)
         ;; Path to org files.
         :base-directory "~/mywebsite/_org"
         :base-extension "org"
         ;; Path to Jekyll Posts
         :publishing-directory "~/mywebsite/_posts"
         :recursive t
         :publishing-function org-html-publish-to-html
         :headline-levels 4
         :html-extension "html"
         :body-only t))))

(after! flycheck
  (setq flycheck-check-syntax-automatically '(save mode-enable)))

(use-package! vertico-multiform
  :load-path "~/.emacs.d/.local/straight/repos/vertico/extensions/"
  :config
  (map! :map vertico-map
    "C-c M-V" 'vertico-multiform-vertical
    "C-c M-G" 'vertico-multiform-grid
    "C-c M-F" 'vertico-multiform-flat
    "C-c M-R" 'vertico-multiform-reverse
    "C-c M-U" 'vertico-multiform-unobtrusive)

  (setq vertico-multiform-commands
    '((consult-line buffer)
      (consult-imenu buffer)))
       ;; (execute-extended-command flat)))

  (vertico-multiform-mode t))

(after! bufler
  (require 'ysz-bufler-config)
  (bufler-mode 1)
  (bufler-tabs-mode 1)
  (map! "C-c b" 'bufler-switch-buffer
        "C-c C-S-b" 'bufler-list)

  (evil-define-key 'normal bufler-list-mode-map
        "K" 'bufler-list-buffer-kill
        "gs" 'bufler-list-buffer-save
        "q" 'quit-window
        (kbd "RET") 'bufler-list-buffer-switch
        "n" 'magit-section-forward-sibling
        "p" 'magit-section-backward-sibling
        (kbd "TAB") 'magit-section-toggle
        (kbd "?") 'hydra:bufler/body
        "f" 'bufler-list-group-frame
        "F" 'bufler-list-group-make-frame))

(after! charge)

(after! minions
  (require 'minions)
  (minions-mode 1))

(after! keycast
  (require 'keycast)
  (setq keycast-header-line-insert-after 'mode-line-position)
  (keycast-header-line-mode 1))

(use-package! lin
  :init
  (setq lin-face 'lin-blue)
  ;; You can use this to live update the face:
  ;;
  ;; (customize-set-variable 'lin-face 'lin-green)
  (setq lin-mode-hooks
       '(bongo-mode-hook
         dired-mode-hook
         elfeed-search-mode-hook
         git-rebase-mode-hook
         grep-mode-hook
         ibuffer-mode-hook
         ilist-mode-hook
         ledger-report-mode-hook
         log-view-mode-hook
         magit-log-mode-hook
         mu4e-headers-mode-hook
         notmuch-search-mode-hook
         notmuch-tree-mode-hook
         occur-mode-hook
         org-agenda-mode-hook
         pdf-outline-buffer-mode-hook
         proced-mode-hook
         tabulated-list-mode-hook))
  :config
  (lin-global-mode 1))

;; (after! ef-themes
;;   (setq ef-themes-to-toggle '(ef-day ef-dark))
;;   (map! "<f12>" 'ef-themes-toggle))

(use-package! doom-modeline
  :config
  (setq doom-modeline-hud nil)
  (setq doom-modeline-icon t)
  (setq doom-modeline-major-mode-icon t)
  (setq doom-modeline-height 10))

(after! beacon
  (setq beacon-blink-when-window-scrolls t)
  (setq beacon-blink-when-focused t)
  (setq beacon-blink-when-point-moves-vertically t)
  (beacon-mode 1))
