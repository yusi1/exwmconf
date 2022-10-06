(require 'org)

;; Org mode hooks
(add-hook 'org-mode-hook (lambda () (setq display-line-numbers-mode 'nil)))
(add-hook 'org-mode-hook (lambda () (auto-fill-mode)))

;; Global Org mode keybinds
(progn
  (gkey "C-c l" 'org-store-link)
  (gkey "C-c a" 'org-agenda)
  (gkey "C-c c" 'org-capture)
  (gkey "C-c g g" 'org-capture-goto-file)
  (gkey "C-c g j" 'org-goto-journal)
  (gkey "C-c g t" 'org-goto-gtd-dir))

;; Internal Org mode keybinds
(let ((map org-mode-map))
  (keymap-set map "<double-mouse-1>" 'org-cycle)
  (keymap-set map "<f8>" 'org-tree-slide-mode)
  (keymap-set map "s-<f8>" 'org-tree-slide-skip-done-toggle)
  ;; (keymap-set map "C-c s a" 'ag)
  (keymap-set map "C-c h e" 'org-encrypt-entry)
  (keymap-set map "C-c h d" 'org-decrypt-entry)
  (keymap-set map "M-n" 'org-next-item)
  (keymap-set map "M-p" 'org-previous-item))

;; Configuration
(visual-line-mode 1)

;; Improve org mode looks
(setq
 ;; Startup folded
 org-startup-folded t
 ;; Startup with inline images
 org-startup-with-inline-images nil
 ;; Image width
 org-image-actual-width '(600)
 ;; Startup indented
 org-startup-indented t
 ;; Use UTF-8 characters for Org-mode
 org-pretty-entities t
 ;; Hide emphasis markers like =code= or ~code~ etc..
 org-hide-emphasis-markers nil
 ;; Hide leading stars
 org-hide-leading-stars nil
 ;; Use custom ellipsis for headings
 org-ellipsis "…"
 ;; Don't auto-align tags
 org-auto-align-tags nil
 ;; Don't auto-indent tags
 org-tags-column 0
 org-catch-invisible-edits 'show-and-error
 ;; Use special ctrl-a/e keybinds that are content-aware.
 org-special-ctrl-a/e t
 ;; Respect content when inserting new headings.
 org-insert-heading-respect-content t
 ;; For navigation in the `org-goto' buffer
 org-goto-auto-isearch nil)

;; ;; Controlling org heading sizes
;; (unless (featurep 'modus-themes)
;;   (setq org-level-faces
;; 	'(
;; 	  org-level-1 ((t (:height 180)))
;; 	  org-level-2 ((t (:height 120)))
;; 	  org-level-3
;; 	  org-level-4
;; 	  org-level-5
;; 	  org-level-6
;; 	  org-level-7
;; 	  org-level-8
;; 	  )))

;; Enable `org-indent-mode'.
(setq org-indent-mode t)

;; Use fixed pitch font for certain things
;; (defun set-buffer-variable-pitch ()
;;   "Set variable pitch, but set fixed-pitch for tables etc.."
;;   (interactive)
;;   (variable-pitch-mode t))

;; (add-hook 'org-mode-hook 'set-buffer-variable-pitch)

;; `org-agenda' styling
(setq
 org-agenda-tags-column 0
 org-agenda-block-separator ?─
 org-agenda-time-grid
 '((daily today require-timed)
   (800 1000 1200 1400 1600 1800 2000)
   " ┄┄┄┄┄ " "┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄")
 org-agenda-current-time-string
 "⭠ now ─────────────────────────────────────────────────")

;; Set org files directory
(setq org-directory "~/Documents/Captures/GTD")
;; Set org agenda files location
(let ((org-dir-1 (eval `(concat ,org-directory "/Tasks")))
      (org-dir-2 (eval `(concat ,org-directory "/Bills"))))
  (setq org-agenda-files `(,org-dir-1
			   ,org-dir-2)))

;;; Setting up `org-crypt'
(org-crypt-use-before-save-magic)

(setq org-tags-exclude-from-inheritance '("crypt"))

;; Org encryption key
(setq org-crypt-key "Yusef Password Store")

(setq auto-save-default nil)


;; Configuring Org Babel
(org-babel-do-load-languages 'org-babel-load-languages
			     '((shell . t)))
;; Disable confirmation before evaluating code blocks:
;; WARNING: This could lead to accidental evaluation of dangerous code.
(setq org-confirm-babel-evaluate nil)

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
	("j" "Journal" entry (file+olp "~/Documents/Captures/Journal/journal.org"
					    "Personal Thoughts" "Thoughts")
	 "*** %U :crypt:\n%?"
	 :jump-to-captured t)
	;; ("d" "Distro Journal" entry (file+headline "~/Documents/Captures/Journal/Distro-Journal/journal.org"
	;; 					   "[ENTER DISTRO NAME HERE] Notes")
	;;  "* Note 1\n%?")
	("x" "Trashbin" entry (file+headline "~/.notes"
					     "Trashbin")
	 "* %U\n%?"
	 :jump-to-captured t)))

(provide 'org-setup)
