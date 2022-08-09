(require 'vertico)
(require 'vertico-flat)
(require 'vertico-grid)
(require 'vertico-buffer)
(require 'vertico-unobtrusive)
(require 'vertico-multiform)
(require 'vertico-repeat)
(require 'savehist)

(vertico-mode t)

;; Vertico multiform setup
(let ((map vertico-map))
  (define-key map (kbd "M-F") 'vertico-multiform-flat)
  (define-key map (kbd "M-G") 'vertico-multiform-grid)
  (define-key map (kbd "M-B") 'vertico-multiform-buffer)
  (define-key map (kbd "M-D") 'vertico-multiform-unobtrusive))

;; Repeat previous prompt
(define-key global-map (kbd "C-x C-z") 'vertico-repeat)

(setq vertico-multiform-commands
      '((consult-imenu buffer)
	(execute-extended-command flat)))

(vertico-multiform-mode t)

;; How much lines are shown above and below when
;; scrolling in the vertico minibuffer.
(setq vertico-scroll-margin '0)

;; This works with `file-name-shadow-mode'.  When you are in a
;; sub-directory and use, say, `find-file' to go to your home '~/' or
;; root '/' directory, Vertico will clear the old path to keep only
;; your current input.
(add-hook 'rfn-eshadow-update-overlay-hook #'vertico-directory-tidy)

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
