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

(setq doom-font (font-spec :family "Iosevka Comfy" :size 18 :weight 'regular))
(setq doom-serif-font (font-spec :family "Iosevka Comfy Duo" :size 18 :weight 'regular))
(setq doom-unicode-font (font-spec :family "SauceCodePro NF" :size 14 :weight 'regular))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/Captures/GTD")

;; Set org agenda files location
(let ((org-dir-1 (eval `(concat ,org-directory "/Tasks")))
      (org-dir-2 (eval `(concat ,org-directory "/Bills"))))
  (setq org-agenda-files `(,org-dir-1
			   ,org-dir-2)))

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

;; Useful built-in modes
(display-battery-mode)

;; Global keybinds
(map! :map global-map "C-x k" #'kill-this-buffer)
(map! :map global-map "C-x C-b" #'ibuffer)

;; Remove notmuch-hello entry from display-buffer-alist
(setq display-buffer-alist (remove '("^\\*notmuch-hello"
                                     (+popup-buffer)
                                     (actions)
                                     (side . left)
                                     (size . 30)
                                     (window-width . 30)
                                     (window-height . 0.16)
                                     (slot)
                                     (vslot)
                                     (window-parameters
                                      (ttl . 0)
                                      (quit . t)
                                      (select . ignore)
                                      (modeline)
                                      (autosave)
                                      (transient . t)
                                      (no-other-window . t))) display-buffer-alist))

(after! doom-modeline
  (setq doom-modeline-modal-icon nil))

;; (add-hook! 'org-mode-hook 'evil-org-mode)

(after! org

  ;; Setting up `org-crypt'
  (org-crypt-use-before-save-magic)

  (setq org-tags-exclude-from-inheritance '("crypt"))

  ;; Org encryption key
  (setq org-crypt-key "Yusef Password Store")

  ;; Configuring Org Capture Templates
  ;; https://orgmode.org/manual/Capture-templates.html
  ;; https://orgmode.org/manual/Template-elements.html
  ;; http://howardism.org/Technical/Emacs/capturing-intro.html
  (setq org-capture-templates
        '(("t" "Todo" entry (file+headline "~/Documents/Captures/GTD/Tasks/gtd.org" "Tasks")
           "* TODO %?\n  %i\n  %a")
          ("n" "Notes" plain (file "~/.notes")
           "\n* ENTER NOTE TITLE HERE%?\n")
          ("r" "Random Note" plain (file "~/.notes")
           "\n* Random Note\n%?"
           :empty-lines 0)
          ("p" "Project Idea" plain (file "~/Documents/Captures/GTD/Tasks/projects.org")
           "\n* TODO (ENTER PROJECT NAME HERE)%?\n")
          ("b" "Bills & Payments" plain (file "~/Documents/Captures/GTD/Bills/Bills.org")
           "\n* Bills & Payments\n** %?")
          ("j" "Journal" entry (file+headline "~/Documents/Captures/Journal/journal.org"
                                              "Personal Thoughts")
           "** %U :crypt:\n%?"
           :jump-to-captured t)
          ;; ("d" "Distro Journal" entry (file+headline "~/Documents/Captures/Journal/Distro-Journal/journal.org"
          ;; 					   "[ENTER DISTRO NAME HERE] Notes")
          ;;  "* Note 1\n%?")
          ("x" "Trashbin" entry (file+headline "~/.notes"
                                               "Trashbin")
           "* %U\n%?"
           :jump-to-captured t))))

(after! smartparens
  (map! :map smartparens-mode-map
        "C-M-d" #'sp-splice-sexp
        "C-M-k" #'sp-kill-sexp
        "C-k" #'sp-kill-hybrid-sexp
        "C-j" #'sp-newline
        ;; S-expression navigation
        "C-M-f" #'sp-forward-sexp
        "C-M-b" #'sp-backward-sexp
        "C-M-n" #'sp-next-sexp
        "C-M-p" #'sp-previous-sexp
        "C-S-f" #'sp-forward-symbol
        "C-S-b" #'sp-backward-symbol
        ;; Slurping/barfing s-expressions
        ;; I.e adding brackets around sexp's in an intelligent way and
        ;; removing brackets from around sexp's in an intelligent way.
        "C-<right>" #'sp-forward-slurp-sexp
        "C-<left>" #'sp-backward-slurp-sexp
        "M-<right>" #'sp-forward-barf-sexp
        "M-<left>" #'sp-backward-barf-sexp
        ;; Unwrapping s-exps :: https://ebzzry.com/en/emacs-pairs/#unwrapping
        "M-[" #'sp-backward-unwrap-sexp
        "M-]" #'sp-unwrap-sexp
        "M-i" #'sp-change-inner
        "M-;" #'sp-comment
        "C-c p" #'smartparens-strict-mode
        ;; Transposing s-expressions
        "C-M-t" #'sp-transpose-sexp))

(after! notmuch
  (map! :after notmuch :map global-map "C-c e e" 'notmuch)

  ;; (add-hook! 'notmuch-show-mode-hook (lambda () (evil-emacs-state)))
  ;; (add-hook! 'notmuch-search-mode-hook (lambda () (evil-emacs-state)))
  ;; (add-hook! 'notmuch-hello-mode-hook (lambda () (evil-emacs-state)))

  (setq +notmuch-sync-backend 'custom
        ;; Set this to an arbitrary shell command
        +notmuch-sync-command "getmail --rcfile personal -v")

  (defun notmuch-update-maildir ()
    "Call `notmuch new` to update maildir."
    (interactive)
    (let ((name "maildir-update")
          (buffer "*maildir-update*"))
      (make-process
       :name name
       :buffer buffer
       :command '("/usr/local/bin/notmuch"
                  "new"))
      ;; (display-buffer buffer)
      ))

  (add-hook! notmuch-hello-refresh-hook 'notmuch-update-maildir)


  ;; Add things to show in `notmuch-hello'.
  (setq notmuch-saved-searches
        `((:name "all mail" :query "*" :key ,(kbd "a"))
          (:name "personal-inbox" :query "tag:inbox and tag:personal and not tag:redhat and not tag:emacs-devel and not tag:emacs-bugs and not tag:debian" :key ,(kbd "i"))
          (:name "other-inbox" :query "tag:inbox and tag:other" :key ,(kbd "oi"))
          (:name "unread" :query "tag:unread" :key ,(kbd "u"))
          (:name "flagged" :query "tag:flagged" :key ,(kbd "f"))
          (:name "sent" :query "tag:sent" :key ,(kbd "t"))
          (:name "drafts" :query "tag:draft" :key ,(kbd "dr"))
          (:name "urgent" :query "tag:urgent" :key ,(kbd "!"))
          (:name "noip" :query "tag:noip" :key ,(kbd "ni"))
          (:name "redhat" :query "tag:redhat" :key ,(kbd "rh"))
          (:name "debian" :query "tag:debian" :key ,(kbd "db"))
          (:name "emacs-devel" :query "tag:emacs-devel" :key ,(kbd "ed"))
          (:name "emacs-bugs" :query "tag:emacs-bugs" :key ,(kbd "eb")))))

(after! diff-hl
  (map! :map global-map
        "s-{" #'diff-hl-previous-hunk
        "s-}" #'diff-hl-next-hunk))
