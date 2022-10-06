(require 'mct)

(setq mct-live-completion t)
(setq mct-live-update-delay 0.3)

;; (setq mct-display-buffer-action '((
;; 				   display-buffer-reuse-window
;; 				   display-buffer-in-side-window)
;; 				  (side . right)
;; 				  (window-width . 60)))

;; You can place the Completions' buffer wherever you want, by following
;; the syntax of `display-buffer'.
(setq mct-display-buffer-action '((display-buffer-reuse-window
				   display-buffer-at-bottom)))

(setq mct-show-completion-line-numbers t)

(let ((map mct-minibuffer-local-completion-map))
  (keymap-set map "C-l" 'mct-list-completions-toggle))

;; alternating background colours in *Completions* buffer
(setq mct-apply-completion-stripes nil)

;; remove shadowed file paths, for example, when typing `~/' when
;; a path is already in the minibuffer, this will remove the previous
;; path to only leave the `~/'.
(setq mct-remove-shadowed-file-names t)

;; This is for commands or completion categories that should always pop
;; up the completions' buffer.  It circumvents the default method of
;; waiting for some user input (see `mct-minimum-input') before
;; displaying and updating the completions' buffer.
(setq mct-completion-passlist
      '(;; Some commands
        Info-goto-node
        Info-index
        Info-menu
        vc-retrieve-tag
        ;; Some completion categories
        imenu
        file
        buffer
        kill-ring
        consult-location
	consult-buffer))

;; The blocklist follows the same principle as the passlist, except it
;; disables live completions altogether.
(setq mct-completion-blocklist nil)

(setq completions-detailed t)

;; Do not allow the cursor in the minibuffer prompt
(setq minibuffer-prompt-properties
      '(read-only t cursor-intangible t face minibuffer-prompt))
(add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

;; mct capf alternative to corfu or company
(mct-region-mode t)
(mct-minibuffer-mode 1)
(mct-mode t)

;; Minibuffer history
(require 'savehist)
(setq savehist-file (locate-user-emacs-file "savehist"))
(setq history-length 10000)
(setq history-delete-duplicates t)
(setq savehist-save-minibuffer-history t)
(add-hook 'after-init-hook #'savehist-mode)

;;; Some functions
(defun my-sort-by-alpha-length (elems)
  "Sort ELEMS first alphabetically, then by length."
  (sort elems (lambda (c1 c2)
                (or (string-version-lessp c1 c2)
                    (< (length c1) (length c2))))))

(defun my-sort-by-history (elems)
  "Sort ELEMS by minibuffer history.
     Use `mct-sort-sort-by-alpha-length' if no history is available."
  (if-let ((hist (and (not (eq minibuffer-history-variable t))
                      (symbol-value minibuffer-history-variable))))
      (minibuffer--sort-by-position hist elems)
    (my-sort-by-alpha-length elems)))

(defun my-sort-multi-category (elems)
  "Sort ELEMS per completion category."
  (pcase (mct--completion-category)
    ('nil elems) ; no sorting
    ('kill-ring elems)
    ('project-file (my-sort-by-alpha-length elems))
    (_ (my-sort-by-history elems))))

;; Specify the sorting function.
(setq completions-sort #'my-sort-multi-category)

;; run completion if line at point is already indented
(setq tab-always-indent 'complete)

(minibuffer-electric-default-mode t)
(minibuffer-depth-indicate-mode t)

(provide 'mct-setup)
