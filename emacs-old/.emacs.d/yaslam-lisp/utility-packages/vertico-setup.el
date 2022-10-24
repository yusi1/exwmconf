(require 'vertico)
(require 'vertico-flat)
(require 'vertico-grid)
(require 'vertico-buffer)
(require 'vertico-unobtrusive)
(require 'vertico-multiform)
(require 'vertico-repeat)
(require 'vertico-mouse)
(require 'vertico-directory)
(require 'savehist)

(vertico-mode t)
;; put vertico into its own buffer
;; (vertico-buffer-mode t)
;; show line-numbers in vertico
;; (vertico-indexed-mode t)
;; enable mouse support in vertico
(vertico-mouse-mode t)

;; control placement of `vertico-buffer'.
(setq vertico-buffer-display-action '((display-buffer-in-side-window)
				      (window-height . 10)
				      (side . bottom)))

;; Vertico multiform setup
(let ((map vertico-map))
  (keymap-set map "M-V" #'vertico-multiform-vertical)
  (keymap-set map "M-G" #'vertico-multiform-grid)
  (keymap-set map "M-F" #'vertico-multiform-flat)
  (keymap-set map "M-R" #'vertico-multiform-reverse)
  (keymap-set map "M-U" #'vertico-multiform-unobtrusive))

;; Repeat previous prompt
(keymap-set global-map "C-x C-z" 'vertico-repeat)

(setq vertico-multiform-commands
      '((consult-imenu buffer)
	(execute-extended-command flat)))

(vertico-multiform-mode t)

;; `vertico-directory' configuration
(with-eval-after-load 'vertico
  ;; keybinds for `vertico-directory'
  (let ((map vertico-map))
    (keymap-set map "RET" 'vertico-directory-enter)
    (keymap-set map "DEL" 'vertico-directory-delete-char)
    (keymap-set map "M-DEL" 'vertico-directory-delete-word))
  
  ;; This works with `file-name-shadow-mode'.  When you are in a
  ;; sub-directory and use, say, `find-file' to go to your home '~/' or
  ;; root '/' directory, Vertico will clear the old path to keep only
  ;; your current input.
  (add-hook 'rfn-eshadow-update-overlay-hook #'vertico-directory-tidy))

;; How much lines are shown above and below when
;; scrolling in the vertico minibuffer.
(setq vertico-scroll-margin '0)

;; Save Vertico history across restarts
(savehist-mode)

(add-to-list 'savehist-additional-variables 'vertico-repeat-history)

;; More useful configurations
;; Add prompt indicator to `completing-read-multiple'.
;; We display [CRM<separator>], e.g., [CRM,] if the separator is a comma.
(defun crm-indicator (args)
  (cons (format "[CRM%s] %s"
                (replace-regexp-in-string
                 "\\`\\[.*?]\\*\\|\\[.*?]\\*\\'" ""
                 crm-separator)
                (car args))
        (cdr args)))
(advice-add #'completing-read-multiple :filter-args #'crm-indicator)

;; Do not allow the cursor in the minibuffer prompt
(setq minibuffer-prompt-properties
      '(read-only t cursor-intangible t face minibuffer-prompt))
(add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

;; Emacs 28: Hide commands in M-x which do not work in the current mode.
;; Vertico commands are hidden in normal buffers.
;; (setq read-extended-command-predicate
;;       #'command-completion-default-include-p)

;; Enable recursive minibuffers
(setq enable-recursive-minibuffers t)

(provide 'vertico-setup)
