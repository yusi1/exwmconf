(require 'denote)

;; Remember to check the doc strings of those variables.
(setq denote-directory (expand-file-name "~/Documents/notes/"))
(setq denote-known-keywords '("emacs"))
(setq denote-infer-keywords t)
(setq denote-sort-keywords t)
(setq denote-file-type 'text) ; Org is the default, set others here
(setq denote-prompts '(title keywords))


;; Pick dates, where relevant, with Org's advanced interface:
(setq denote-date-prompt-use-org-read-date t)


;; Read this manual for how to specify `denote-templates'.  We do not
;; include an example here to avoid potential confusion.


;; We allow multi-word keywords by default.  The author's personal
;; preference is for single-word keywords for a more rigid workflow.
(setq denote-allow-multi-word-keywords t)

(setq denote-date-format nil) ; read doc string

;; By default, we fontify backlinks in their bespoke buffer.
(setq denote-link-fontify-backlinks t)

;; Also see `denote-link-backlinks-display-buffer-action' which is a bit
;; advanced.

;; If you use Markdown or plain text files (Org renders links as buttons
;; right away)
(add-hook 'find-file-hook #'denote-link-buttonize-buffer)

;; We use different ways to specify a path for demo purposes.
(setq denote-dired-directories
      (list denote-directory
            (thread-last denote-directory (expand-file-name "attachments"))
            (expand-file-name "~/Documents/books")))

;; Generic (great if you rename files Denote-style in lots of places):
;; (add-hook 'dired-mode-hook #'denote-dired-mode)
;;
;; OR if only want it in `denote-dired-directories':
(add-hook 'dired-mode-hook #'denote-dired-mode-in-directories)

;; Here is a custom, user-level command from one of the examples we
;; showed in this manual.  We define it here and add it to a key binding
;; below.
(defun my-denote-journal ()
  "Create an entry tagged 'journal', while prompting for a title."
  (interactive)
  (denote
   (denote--title-prompt)
   '("journal")))

;; Denote DOES NOT define any key bindings.  This is for the user to
;; decide.  For example:
(progn
  (gkey "C-c n j" #'my-denote-journal) ; our custom command
  (gkey "C-c n n" #'denote)
  (gkey "C-c n N" #'denote-type)
  (gkey "C-c n d" #'denote-date)
  (gkey "C-c n s" #'denote-subdirectory)
  (gkey "C-c n t" #'denote-template)
  ;; If you intend to use Denote with a variety of file types, it is
  ;; easier to bind the link-related commands to the `global-map', as
  ;; shown here.  Otherwise follow the same pattern for `org-mode-map',
  ;; `markdown-mode-map', and/or `text-mode-map'.
  (gkey "C-c n i" #'denote-link) ; "insert" mnemonic
  (gkey "C-c n I" #'denote-link-add-links)
  (gkey "C-c n l" #'denote-link-find-file) ; "list" links
  (gkey "C-c n b" #'denote-link-backlinks)
  ;; Note that `denote-rename-file' can work from any context, not just
  ;; Dired bufffers.  That is why we bind it here to the `global-map'.
  (gkey "C-c n r" #'denote-rename-file)
  (gkey "C-c n R" #'denote-rename-file-using-front-matter))

;; Key bindings specifically for Dired.
(let ((map dired-mode-map))
  (keymap-set map "C-c C-d C-i" #'denote-link-dired-marked-notes)
  (keymap-set map "C-c C-d C-r" #'denote-dired-rename-marked-files)
  (keymap-set map "C-c C-d C-R" #'denote-dired-rename-marked-files-using-front-matter))

(with-eval-after-load 'org-capture
  (setq denote-org-capture-specifiers "%l\n%i\n%?")
  (add-to-list 'org-capture-templates
               '("n" "New note (with denote.el) (Org)" plain
                 (file denote-last-path)
                 #'denote-org-capture
                 :no-save t
                 :immediate-finish nil
                 :kill-buffer t
                 :jump-to-captured t)))

(provide 'denote-setup)
