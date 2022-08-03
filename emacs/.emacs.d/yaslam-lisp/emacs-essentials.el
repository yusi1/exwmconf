;; General commands and remappings
(let ((map global-map))
  (define-key map [remap kill-buffer] 'kill-this-buffer))

;; Quicker window navigation
;; With S-<UDLR>
(windmove-default-keybindings)
;; For Emacs in terminal mode
(let ((map global-map))
  (define-key map (kbd "C-c <left>")  'windmove-left)
  (define-key map (kbd "C-c <right>") 'windmove-right)
  (define-key map (kbd "C-c <up>")    'windmove-up)
  (define-key map (kbd "C-c <down>")  'windmove-down))

;; Quicker keybinds
(if (string-match-p "pop-os" (system-name))
    (let ((map global-map))
      (define-key map (kbd "s-)") 'delete-window)
      (define-key map (kbd "s-!") 'delete-other-windows)
      (define-key map (kbd "s-\"") 'split-window-below)
      (define-key map (kbd "s-£") 'split-window-right)
      (define-key map (kbd "s-O") 'other-window)
      (define-key map (kbd "s-B") 'consult-buffer)
      (define-key map (kbd "s-F") 'find-file)
      (define-key map (kbd "s-K") 'kill-this-buffer)
      (define-key map (kbd "s-S") 'save-buffer)
      (define-key map (kbd "s-:") 'other-window-kill-buffer)))

(if (string-match-p "mintyness" (system-name))
    (let ((map global-map))
      (define-key map (kbd "M-)") 'delete-window)
      (define-key map (kbd "M-!") 'delete-other-windows)
      (define-key map (kbd "M-\"") 'split-window-below)
      (define-key map (kbd "M-£") 'split-window-right)
      (define-key map (kbd "M-O") 'other-window)
      (define-key map (kbd "M-B") 'consult-buffer)
      (define-key map (kbd "M-F") 'find-file)
      (define-key map (kbd "M-K") 'kill-this-buffer)
      (define-key map (kbd "M-S") 'save-buffer)
      (define-key map (kbd "M-:") 'other-window-kill-buffer)))

;; Bookmark menu
(let ((map global-map))
  (define-key map (kbd "C-c b") 'bookmark-bmenu-list)
  (define-key map (kbd "C-c C-b") 'bookmark-bmenu-list))

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

(define-key global-map (kbd "C-:") 'other-window-kill-buffer)

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

(let ((map global-map))
  (define-key map (kbd "C-c s s") 'view-as-root)
  (define-key map (kbd "C-c s c") 'view-as-root-new-buffer)
  (define-key map (kbd "C-c s f") 'find-file-as-root)
  (define-key map (kbd "C-c s <mouse-3>") 'find-file-as-root) ; This keybind will open a graphical dialogue to find a file as root.
  (define-key map (kbd "C-c s d") 'dired-root)
  (define-key map (kbd "C-c s v") 'find-file-vps)
  (define-key map (kbd "C-c s r") 'find-file-openwrt))

(defun search-nextcloud-dir ()
  "Search the Nextcloud directory, usually in /home/<user>/Nextcloud."
  (interactive)
  (find-file (read-file-name "Find file (Nextcloud): " "~/Nextcloud/")))

(define-key global-map (kbd "C-c n s") 'search-nextcloud-dir)

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

(let ((map global-map))
  (define-key map (kbd "C-c W") 'change-symbol)
  (define-key map (kbd "C-c w") 'change-word))

(defun ysz/untitled-buffer ()
  "Create an untitled buffer and switch to it."
  (interactive)
  (and (get-buffer-create "untitled")
       (switch-to-buffer "untitled")))

(define-key global-map (kbd "C-c C-n") 'ysz/untitled-buffer)

(defun get-de-p ()
  "Get desktop environment."
  (interactive)
  (shell-command-to-string "echo $XDG_CURRENT_DESKTOP | tr -d '\n'"))

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
  (setq org-journal-file "~/Documents/Journal/journal.org")
  (find-file org-journal-file))

(defun org-goto-gtd-dir ()
  "Goto the Org GTD directory."
  (interactive)
  (find-file org-directory))

(provide 'emacs-essentials)
