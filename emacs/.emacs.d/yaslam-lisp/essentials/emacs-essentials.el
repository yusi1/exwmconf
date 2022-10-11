(require 'crux)

;; General commands and remappings
(progn
  (gremap global-map "kill-buffer" 'kill-this-buffer)
  ;; (gkey "C-x b" 'consult-buffer)
  (gkey "C-x C-b" 'ibuffer)
  (gkey "C-x w n" 'next-window-any-frame)
  (gkey "C-x w p" 'previous-window-any-frame)
  (gkey "C-x 4 t" (lambda () (interactive) (crux-transpose-windows 1)))
  (gkey "C-c I" 'crux-find-user-init-file)
  (gkey "s-k" 'crux-kill-whole-line)
  (gkey "C-c x" 'crux-open-with))

;; Quicker window navigation
;; With S-<UDLR>
(windmove-default-keybindings)
;; For Emacs in terminal mode
(progn
  (gkey "C-c <left>" 'windmove-left)
  (gkey "C-c <right>" 'windmove-right)
  (gkey "C-c <up>" 'windmove-up)
  (gkey "C-c <down>" 'windmove-down))

;; Window history mode, `winner-mode'.
(winner-mode)

;; Tab bar history mode
(tab-bar-history-mode)

;; electric pair mode
(electric-pair-mode)

;; Visual line mode hooks
(add-hook 'helpful-mode-hook #'visual-line-mode)
(add-hook 'help-mode-hook #'visual-line-mode)
(add-hook 'custom-mode-hook #'visual-line-mode)

;; Quicker keybinds
;; (if (string-match-p "voidlaptop" (system-name))
(progn
  (gkey "s-)" 'delete-window)
  (gkey "s-!" 'delete-other-windows)
  (gkey "s-\"" 'split-window-below)
  (gkey "s-\\" 'next-window-any-frame)
  (gkey "s-\|" 'previous-window-any-frame)
  (gkey "s-£" 'split-window-right)
  (gkey "s-O" 'other-window)
  (gkey "s-B" 'consult-buffer)
  (gkey "s-F" 'find-file)
  (gkey "s-K" 'kill-this-buffer)
  (gkey "s-S" 'save-buffer)
  (gkey "s-:" 'other-window-kill-buffer)
  (gkey "s-{" 'diff-hl-previous-hunk)
  (gkey "s-}" 'diff-hl-next-hunk)
  ;; (gkey "s-¬" 'tab-bar-mode)
  (gkey "s-¬" 'prot-tab-status-line)
  (gkey "s-T" 'tranpose-windows))
;; )

;; (if (string-match-p "voiddesktop" (system-name))
;;     (let ((map global-map))
;;       (define-key map (kbd "M-)") 'delete-window)
;;       (define-key map (kbd "M-!") 'delete-other-windows)
;;       (define-key map (kbd "M-\"") 'split-window-below)
;;       (define-key map (kbd "M-£") 'split-window-right)
;;       (define-key map (kbd "M-O") 'other-window)
;;       (define-key map (kbd "M-B") 'consult-buffer)
;;       (define-key map (kbd "M-F") 'find-file)
;;       (define-key map (kbd "M-K") 'kill-this-buffer)
;;       (define-key map (kbd "M-S") 'save-buffer)
;;       (define-key map (kbd "M-:") 'other-window-kill-buffer)))

;; Bookmark menu
(progn
  (gkey "C-c b" 'bookmark-bmenu-list)
  (gkey "C-c C-b" 'bookmark-bmenu-list))

;; Make yes/no prompts be y/n prompts
(defalias 'yes-or-no-p 'y-or-n-p)

;;; Useful functions
(defun other-window-kill-buffer ()
  "Kill the buffer in the next window, then switch back to the previous window and delete all other windows."
  (interactive)
  (other-window 1)
  (kill-buffer)
  (previous-window-any-frame)
  (delete-other-windows)
  (message "Killing buffer in the next window."))

(gkey "C-:" 'other-window-kill-buffer)

;; Make the current file being viewed in the buffer
;; get viewed with root privileges using TRAMP and `su'.
(defun view-as-root ()
  "Use TRAMP to view the current buffer with root privileges."
  (interactive)
  (when buffer-file-name
    (find-alternate-file
     (concat "/sudo:root@localhost:"
	     buffer-file-name))
    (message (concat "Viewing file: \"" buffer-file-name "\" with root privileges."))))

;; Another version of the same function that doesn't close the un-su'ed buffer
;; it just keeps it open and creates a new buffer that is su'ed.
;; This stops issues like EmacsClient closing the window when the original un-su'ed buffer has exited (default behaviour).
(defun view-as-root-new-buffer ()
  "Use TRAMP to view the current file with root privileges in a new buffer."
  (interactive)
  (when buffer-file-name
    (find-file
     (concat "/sudo:root@localhost:"
	     buffer-file-name))
    (message (concat "Viewing file: \"" buffer-file-name "\" with root privileges in a new buffer."))))

(defun find-file-as-root ()
  "Use TRAMP to execute `selectrum-find-file-in-dir' using root privileges in root dir.
This is just a simpler version of the above functions for browsing root dir '/' in the minibuffer using root privileges and TRAMP..
"
  (interactive)
  (find-file (concat "/sudo:root@localhost:"
		     (read-file-name "Find file (as root): " "/"))))

(defun dired-root ()
  "Use TRAMP to execute `find-file' using root privileges in root dir.
This is just a simpler version of the above functions for browsing root dir '/' with `dired' using root privileges and TRAMP..
"
  (interactive)
  (find-file (concat "/sudo:root@localhost:" "/")))

(defun find-file-vps ()
  "Use TRAMP to connect to Debian OVH VPS."
  (interactive)
  (find-file (read-file-name "Find file (GCP - root): " "/ssh:yaslam@vps1|sudo::/")))

(defun find-file-openwrt ()
  (interactive)
  (find-file (read-file-name "Find file (OpenWRT - root): " "/ssh:root@192.168.2.1:/")))

(progn
  (gkey "C-c s s" 'view-as-root)
  (gkey "C-c s c" 'view-as-root-new-buffer)
  (gkey "C-c s f" 'find-file-as-root)
  (gkey "C-c s <mouse-3>" 'find-file-as-root) ; This keybind will open a graphical dialogue to find a file as root.
  (gkey "C-c s d" 'dired-root)
  (gkey "C-c s v" 'find-file-vps)
  (gkey "C-c s r" 'find-file-openwrt))

(defun search-nextcloud-dir ()
  "Search the Nextcloud directory, usually in /home/<user>/Nextcloud."
  (interactive)
  (find-file (read-file-name "Find file (Nextcloud): " "~/Nextcloud/")))

(gkey "C-c s n" 'search-nextcloud-dir)

(defun transpose-words-backwards ()
  "Transpose words, but backwards."
  (interactive)
  (transpose-words -1))

(require 'cl)
(defun change-word (n)
  (interactive "p")
  (lexical-let ((old-window-configuration (current-window-configuration)))
    (clone-indirect-buffer "*edit-word*" t)
    (narrow-to-region (point) (save-excursion
                                (forward-word n)
                                (point)))
    (overwrite-mode 1)
    (local-set-key (kbd "C-c C-c")
                   (lambda ()
                     (interactive)
                     (widen)
                     (let ((end-of-edit (point)))
                       (kill-buffer)
                       (set-window-configuration old-window-configuration)
                       (goto-char end-of-edit))))))

(defun change-symbol (n)
  (interactive "p")
  (lexical-let ((old-window-configuration (current-window-configuration)))
    (clone-indirect-buffer "*edit-word*" t)
    (narrow-to-region (point) (save-excursion
                                (forward-symbol n)
                                (point)))
    (overwrite-mode 1)
    (local-set-key (kbd "C-c C-c")
                   (lambda ()
                     (interactive)
                     (widen)
                     (let ((end-of-edit (point)))
                       (kill-buffer)
                       (set-window-configuration old-window-configuration)
                       (goto-char end-of-edit))))))

(progn 
  (gkey "C-c W" 'change-symbol)
  (gkey "C-c w" 'change-word))

;; (defun ysz/untitled-buffer ()
;;   "Create an untitled buffer and switch to it."
;;   (interactive)
;;   (and (get-buffer-create "untitled")
;;        (switch-to-buffer "untitled")))

;; (gkey "C-c C-n" 'ysz/untitled-buffer)
(gkey "C-c C-n" 'scratch-buffer)

;; Get the current desktop environent from
;; global variable `$XDG_CURRENT_DESKTOP'.
(defun get-de-p ()
  "Get desktop environment."
  (interactive)
  (getenv "XDG_CURRENT_DESKTOP"))

(defun get-public-ip ()
  "Get Public IP address from a shell command."
  (interactive)
  (message
   (shell-command-to-string "curl -s ifconfig.me")))

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

(defvar-local hidden-mode-line-mode nil)

(define-minor-mode hidden-mode-line-mode
  "Minor mode to hide the mode-line in the current buffer."
  :init-value nil
  :global t
  :variable hidden-mode-line-mode
  :group 'editing-basics
  (if hidden-mode-line-mode
      (setq hide-mode-line mode-line-format
            mode-line-format nil)
    (setq mode-line-format hide-mode-line
          hide-mode-line nil))
  (force-mode-line-update)
  ;; Apparently force-mode-line-update is not always enough to
  ;; redisplay the mode-line
  (redraw-display)
  (when (and (called-interactively-p 'interactive)
             hidden-mode-line-mode)
    (run-with-idle-timer
     0 nil 'message
     (concat "Hidden Mode Line Mode enabled.  "
             "Use M-x hidden-mode-line-mode to make the mode-line appear."))))

;; If you want to hide the mode-line in every buffer by default
;; (add-hook 'after-change-major-mode-hook 'hidden-mode-line-mode)

(gkey "s-M" 'hidden-mode-line-mode)

;; Function to dedicate a window to a buffer and nothing else.
(defun mp-toggle-window-dedication ()
  "Toggles window dedication in the selected window."
  (interactive)
  (set-window-dedicated-p (selected-window)
			  (not (window-dedicated-p (selected-window)))))

;; Function to improve `add-to-list' behaviour with a new function.
;; Came from the `org-capture-templates' and `add-to-list' rabbit hole.
;; https://emacs.stackexchange.com/questions/38008/adding-many-items-to-a-list/68048#68048
;; https://www.reddit.com/r/DoomEmacs/comments/poxx5n/comment/hz12x3k/
(defun add-list-to-list (dst src)
  "Similar to `add-to-list', but accepts a list as 2nd argument"
  (set dst
       (append (eval dst) src)))

;; (defun open-external-app ()
;;   "Open a file in an external app with the default shell's `xdg-open' command."
;;   (interactive)
;;   (let ((current-file (buffer-file-name)))
;;     (cond ((string-equal system-type "gnu/linux")
;; 	   (call-process shell-file-name nil nil nil
;; 			 shell-command-switch
;; 			 (format "xdg-open %s" current-file)))
;; 	  ((string-equal system-type "windows-nt")
;; 	   (shell-command (concat "PowerShell -Command \"Invoke-Item -LiteralPath\" " "'" current-file)) "'"))))

;; (gkey "C-c x" 'open-external-app)

(provide 'emacs-essentials)
