(require 'org)
(require 'org-superstar)

;; Org mode hooks
(add-hook 'org-mode-hook (lambda () (setq display-line-numbers-mode 'nil)))
(add-hook 'org-mode-hook (lambda () (auto-fill-mode)))
(add-hook 'org-mode-hook (lambda () (org-indent-mode t)))
(add-hook 'org-mode-hook (lambda () (if (display-graphic-p)
					(org-superstar-mode 1))))

;; Global Org mode keybinds
(let ((map global-map))
  (define-key map (kbd "C-c l") 'org-store-link)
  (define-key map (kbd "C-c a") 'org-agenda)
  (define-key map (kbd "C-c c") 'org-capture)
  (define-key map (kbd "C-c g g") 'org-capture-goto-file)
  (define-key map (kbd "C-c g j") 'org-goto-journal)
  (define-key map (kbd "C-c g t") 'org-goto-gtd-dir))

;; Internal Org mode keybinds
(let ((map org-mode-map))
  (define-key map (kbd "<double-mouse-1>") 'org-cycle)
  (define-key map (kbd "<f8>") 'org-tree-slide-mode)
  (define-key map (kbd "S-<f8>") 'org-tree-slide-skip-done-toggle)
  ;; (define-key map (kbd "C-c s a") 'ag)
  (define-key map (kbd "C-c h e") 'org-encrypt-entry)
  (define-key map (kbd "C-c h d") 'org-decrypt-entry)
  (define-key map (kbd "M-n") 'org-next-item)
  (define-key map (kbd "M-p") 'org-previous-item))

;; Configuration
(visual-line-mode 1)
;; Improve org mode looks
(setq org-startup-folded t)
(setq org-startup-with-inline-images t)
(setq org-image-actual-width '(600))
(setq org-startup-indented t)
(setq org-pretty-entities t)
(setq org-hide-emphasis-markers nil)
(setq org-hide-leading-stars nil)
;; Don't align tags
(setq org-auto-align-tags t)
;; For navigation in the `org-goto' buffer
(setq org-goto-auto-isearch nil)
;; Set org files directory
(setq org-directory "~/Documents/GTD")
;; Set org agenda files location
(setq org-agenda-files '("~/Documents/GTD/Tasks"
			 "~/Documents/GTD/Bills"))
;; Disable leading stars
(setq org-superstar-remove-leading-stars t)
;; Org fold workaround for strange behaviour https://list.orgmode.org/87sfplyko3.fsf@localhost/
;; (setq org-fold-core-style 'overlays)
;; Indentation
;; (setq org-indent-mode t)

  ;;; Setting up `org-crypt'
(org-crypt-use-before-save-magic)

(setq org-tags-exclude-from-inheritance '("crypt"))

;; Org encryption key
(setq org-crypt-key "Yusef Password Store")

(setq auto-save-default nil)

;; ;; Use fixed pitch font for certain things
(defun set-buffer-variable-pitch ()
  "Set variable pitch, but set fixed-pitch for tables etc.."
  (interactive)
  (variable-pitch-mode t))

(add-hook 'org-mode-hook 'set-buffer-variable-pitch)

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
      '(("t" "Todo" entry (file+headline "~/Documents/GTD/Tasks/gtd.org" "Tasks")
         "* TODO %?\n  %i\n  %a")
	("n" "Notes" plain (file "~/.notes")
	 "\n* ENTER NOTE TITLE HERE%?\n")
	("r" "Random Note" plain (file "~/.notes")
	 "\n* Random Note\n%?"
	 :empty-lines 0)
	("p" "Project Idea" plain (file "~/Documents/GTD/Tasks/projects.org")
	 "\n* TODO (ENTER PROJECT NAME HERE)%?\n")
	("b" "Bills & Payments" plain (file "~/Documents/GTD/Bills/Bills.org")
	 "\n* Bills & Payments\n** %?")
	("j" "Journal" entry (file+headline "~/Documents/Journal/journal.org"
					    "Personal Thoughts")
	 "* %U :crypt:\n%?"
	 :jump-to-captured t)
	;; ("d" "Distro Journal" entry (file+headline "~/Documents/Journal/Distro-Journal/journal.org"
	;; "[ENTER DISTRO NAME HERE] Notes")
	;; "* Note 1\n%?")
	("x" "Trashbin" entry (file+headline "~/.notes"
					     "Trashbin")
	 "* %U\n%?"
	 :jump-to-captured t)))

(provide 'org-setup)
