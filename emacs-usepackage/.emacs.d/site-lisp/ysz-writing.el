;;; Writing configurations (Org et al.) --- ysz-writing.el

(use-package general)

(use-package org
  :straight t
  :hook ((org-mode . (lambda () (auto-fill-mode 1)))
	 (org-mode . (lambda () (visual-line-mode 1))))
  :config
  (general-def
    :keymap global-map
    :prefix "C-c"
    "l" 'org-store-link
    "a" 'org-agenda
    "c" 'org-capture)
  (general-def
    :keymap global-map
    :prefix "C-c g"
    "g" (lambda () (interactive) (org-capture-goto-file))
    "j" (lambda () (interactive) (org-goto-journal))
    "t" (lambda () (interactive) (org-goto-gtd-dir)))
  (general-def
    :keymap org-mode-map
    "<double-mouse-1>" 'org-cycle
    "M-n" 'org-next-item
    "M-p" 'org-previous-item)
  (general-def
    :prefix "C-c h"
    "e" 'org-encrypt-entry
    "d" 'org-decrypt-entry)
  ;;;;;;;;;;;;;;;;;;;;;;
  (setq
   org-startup-folded t
   org-startup-with-inline-images nil
   org-image-actual-width '(600)
   org-startup-indented t
   org-pretty-entities t
   org-hide-emphasis-markers nil
   org-hide-leading-stars nil
   org-ellipsis "…"
   org-auto-align-tags nil
   org-tags-column 0
   org-catch-invisible-edits 'show-and-error
   org-special-ctrl-a/e t
   org-insert-heading-respect-content t
   org-goto-auto-isearch nil)
  (setq org-indent-mode t)
  ;;;;;;;;;;;;;;;;;;;;;;;;;;
  (setq
   org-agenda-tags-column 0
   org-agenda-block-separator ?─
   org-agenda-time-grid
   '((daily today require-timed)
     (800 1000 1200 1400 1600 1800 2000)
     " ┄┄┄┄┄ " "┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄")
   org-agenda-current-time-string
   "⭠ now ─────────────────────────────────────────────────")
  ;;;;;;;;;;;;;;;;;;;;;;;;;
  (setq org-directory "~/Documents/Captures/GTD")
  (let ((org-dir-1 (eval `(concat ,org-directory "/Tasks")))
	(org-dir-2 (eval `(concat ,org-directory "/Bills"))))
    (setq org-agenda-files `(,org-dir-1
			     ,org-dir-2)))
  ;;;;;;;;;;;;;;;;;;;;;;;;
  (org-babel-do-load-languages 'org-babel-load-languages '((shell . t)))
  (setq org-confirm-babel-evaluate nil)
  ;;;;;;;;;;;;;;;;;;;;;;;;
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
	   :jump-to-captured t))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package org-crypt
  :config
  (org-crypt-use-before-save-magic)
  (setq org-tags-exclude-from-inheritance '("crypt"))
  (setq org-crypt-key "Yusef Password Store")
  (setq auto-save-default nil))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package org-superstar
  :straight '(org-superstar :type git :flavor melpa
			    :host github :repo "integral-dw/org-superstar-mode")
  :after (org)
  :hook ((org-mode . (lambda () (org-superstar-mode 1)))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun org-capture-goto-file ()
  "Goto the org-capture file and turn on org-mode for that file."
  (interactive)
  (setq org-capture-file "~/.notes")
  (find-file org-capture-file))

(defun org-goto-journal ()
  "Goto the Org journal file."
  (interactive)
  (setq org-journal-file "~/Documents/Captures/Journal/journal.org")
  (find-file org-journal-file))

(defun org-goto-gtd-dir ()
  "Goto the Org GTD directory."
  (interactive)
  (find-file org-directory))

(provide 'ysz-writing)
;;; ysz-writing.el ends here
