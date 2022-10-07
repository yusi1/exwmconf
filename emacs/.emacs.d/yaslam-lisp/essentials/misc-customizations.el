(require 'tab-bar)

;;;###autoload
(define-minor-mode prot-tab-status-line
  "Make Tab bar a status line and configure the extras.
Hide the mode lines and change their colors."
  :global t
  :group 'prot-tab
  (if prot-tab-status-line
      (progn
        (setq tab-bar-show t)
        (tab-bar-mode 1)
        (tab-bar-history-mode -1)
        (display-time-mode 1))
    (setq tab-bar-show nil)
    (tab-bar-mode -1)
    (tab-bar-history-mode -1)
    (display-time-mode 1)))

;; (add-hook 'after-init-hook 'prot-tab-status-line)

(setq tab-bar-format '(tab-bar-format-history tab-bar-format-tabs tab-bar-separator tab-bar-format-align-right tab-bar-format-global))
(setq tab-bar-close-button-show nil)

;; (require 'world-clock)
(setq world-clock-list
      '(("Europe/London" "London")
	("Europe/Greece" "Athens")
	))

(require 'dictionary)
(gkey "C-c d" #'dictionary-search)
(setq dictionary-server "dict.org")

(setq dired-x-hands-off-my-keys nil)
(require 'dired-x)
;; (gremap global-map "find-file" 'dired-x-find-file)

(require 'dired)
(setq dired-listing-switches "-ahl -v --group-directories-first")
;; (setq list-directory-verbose-switches "-ahl -v --group-directories-first")

(require 'tooltip)
(setq tooltip-delay 0.5)
(setq tooltip-short-delay 0.5)
(setq x-gtk-use-system-tooltips nil)
(setq tooltip-frame-parameters
      '((name . "tooltip")
        (internal-border-width . 6)
        (border-width . 0)
        (no-special-glyphs . t)))
(add-hook 'after-init-hook #'tooltip-mode)

;; Enable some commands that are disabled by default
(put 'downcase-region 'disabled nil)

(require 'info)
(let ((map Info-mode-map))
  (define-key map (kbd "N") 'Info-next-reference)
  (define-key map (kbd "P") 'Info-prev-reference))

(require 'speedbar)
(gkey "C-c `" 'speedbar)

(require 'eshell)
;; Enhanced completion akin to fish shell / zsh
(require 'pcmpl-args)

;; (setq eshell-prompt-function (lambda nil
;; 			       (concat
;; 				(propertize (eshell/pwd) 'face `(:foreground "blue"))
;; 				(propertize " $" 'face `(:foreground "dark violet"))
;; 				(propertize " " 'face `(:foreground "black")))))
;; (setq eshell-highlight-prompt nil)

(add-hook 'eshell-mode-hook (lambda () (setq-local imenu-generic-expression
						   '(("Prompt" " $ \\(.*\\)" 1)))))

;; Buffer and window customizations
(require 'window)

(defun prot/display-buffer-shell-or-term-p (buffer &rest _)
  "Check if BUFFER is a shell or terminal.
   This is a predicate function for `buffer-match-p', intended for
   use in `display-buffer-alist'."
  (when (string-match-p "\\*.*\\(e?shell\\|v?term\\).*" (buffer-name buffer))
    (with-current-buffer buffer
      ;; REVIEW 2022-07-14: Is this robust?
      (and (or (not (derived-mode-p 'message-mode))
	       (not (derived-mode-p 'text-mode)))
	   (or (derived-mode-p 'eshell-mode)
	       (derived-mode-p 'shell-mode)
	       (derived-mode-p 'comint-mode)
	       (derived-mode-p 'fundamental-mode))))))

(setq lexical-binding t)

;; Lexical binding needed for this function.
(defun make-display-buffer-matcher-function (major-modes)
  (lambda (buffer-name action)
    (with-current-buffer buffer-name (apply #'derived-mode-p major-modes))))

(setq display-buffer-alist
      `(("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*" nil
	 (window-parameters
	  (mode-line-format . none)))
	("^ \\*org-contact\\*" display-buffer-below-selected)
	;; ("\\*info\\*"
        ;;  (display-buffer-reuse-window display-buffer-pop-up-frame)
        ;;  (pop-up-frame-parameters . ((width . (text-pixels . 1280))
	;; 			     (height . (text-pixels . 720))))
	;;  (reusable-frames . 0)
	;;  (dedicated . t))
	;; (prot/display-buffer-shell-or-term-p
	;;  (display-buffer-reuse-window display-buffer-pop-up-frame)
	;;  (pop-up-frame-parameters . ((width . (text-pixels . 800))
	;; 			     (height . (text-pixels . 600))
	;; 			     (tab-bar-lines . 0)))
	;;  (window-parameters . ((no-other-window . t)
	;; 		       (mode-line-format . none)))
	;;  (reusable-frames . 0)
	;;  (dedicated . t))
        ;; ((or . ((derived-mode . helpful-mode)
	;; 	"\\*Help\\*"))
        ;;  (display-buffer-reuse-window display-buffer-in-side-window)
	;;  (side . right)
	;;  (window-width . 60)
        ;;  (inhibit-same-window . t))
        ((or . ((derived-mode . backtrace-mode)
                "\\*\\(Warnings\\|Compile-Log\\)\\*"))
         (display-buffer-in-side-window)
         (window-height . 0.30)
         (side . top)
         (slot . 2)
	 (window-parameters . ((mode-line-format . (:propertize
						    mode-line-buffer-identification)))))
        ("\\*notmuch-hello\\*"
         (display-buffer-reuse-window display-buffer-same-window))
        ((derived-mode . magit-mode)
	 (display-buffer-same-window))
	("\\*Password-Store\\*"
	 (display-buffer-full-frame)
	 ;; (side . left)
         ;; (window-width . 60)
         (window-parameters . ((no-other-window . nil)
			       ;; (mode-line-format . nil)
			       ))
	 (inhibit-same-window . t)
	 (dedicated . t)
	 (reusable-frames . 0))
	;; ((derived-mode . pass-view-mode)
	;;  (display-buffer-in-side-window)
	;;  (side . right)
	;;  (slot . 1)
	;;  (window-width . 80))
	))

;; Requires Emacs 27+
(setq switch-to-buffer-obey-display-actions nil)

;; (setq window-combination-resize t)
;; (setq even-window-sizes 'height-only)
;; (setq window-sides-vertical nil)
(setq switch-to-buffer-in-dedicated-window 'pop)

(provide 'misc-customizations)
