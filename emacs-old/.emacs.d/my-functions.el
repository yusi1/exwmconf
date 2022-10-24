;;; My custom functions

;; Make the current file being viewed in the buffer
;; get viewed with root privileges using TRAMP and `su'.
(defun view-as-root ()
  "Use TRAMP to view the current buffer with root privileges."
  (interactive)
  (when buffer-file-name
    (find-alternate-file
     (concat "/su:root@localhost:"
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
     (concat "/su:root@localhost:"
	     buffer-file-name))
    (message (concat "Viewing file: \"" buffer-file-name "\" with root privileges in a new buffer."))))

(defun find-file-as-root ()
  "Use TRAMP to execute `selectrum-find-file-in-dir' using root privileges in root dir.
This is just a simpler version of the above functions for browsing root dir '/' in the minibuffer using root privileges and TRAMP..
"
  (interactive)
  (find-file (concat "/su:root@localhost:"
		     (read-file-name "Find file (as root): " "/"))))

(defun dired-root ()
  "Use TRAMP to execute `find-file' using root privileges in root dir.
This is just a simpler version of the above functions for browsing root dir '/' with `dired' using root privileges and TRAMP..
"
  (interactive)
  (find-file (concat "/su:root@localhost:" "/")))

(defun find-file-vps ()
  "Use TRAMP to connect to Debian OVH VPS."
  (interactive)
  (find-file (read-file-name "Find file (GCP - root): " "/ssh:yaslam@vps1|sudo::/")))

(defun find-file-openwrt ()
  (interactive)
  (find-file (read-file-name "Find file (OpenWRT - root): " "/ssh:root@192.168.2.1:/")))

(global-set-key (kbd "C-c s s") 'view-as-root)
(global-set-key (kbd "C-c s c") 'view-as-root-new-buffer)
(global-set-key (kbd "C-c s f") 'find-file-as-root)
(global-set-key (kbd "C-c s <mouse-3>") 'find-file-as-root) ; This keybind will open a graphical dialogue to find a file as root.
(global-set-key (kbd "C-c s d") 'dired-root)
(global-set-key (kbd "C-c s v") 'find-file-vps)
(global-set-key (kbd "C-c s r") 'find-file-openwrt)

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

(global-set-key (kbd "C-c W") 'change-symbol)
(global-set-key (kbd "C-c w") 'change-word)

;;; Function ideas
;; #1 Create a function to kill the buffer in the other window

(defun other-window-kill-buffer ()
  "Kill the buffer in the next window, then switch back to the previous window and delete all other windows."
  (interactive)
  (other-window 1)
  (kill-buffer)
  (previous-window-any-frame)
  (delete-other-windows)
  (message "Killing buffer in the next window."))

;;; Some more functions for other things

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

(defun ysz/untitled-buffer ()
  "Create an untitled buffer and switch to it."
  (interactive)
  (and (get-buffer-create "untitled")
       (switch-to-buffer "untitled")))

(global-set-key (kbd "C-c C-n") 'ysz/untitled-buffer)

(defun get-public-ip ()
  "Get Public IP address from a shell command."
  (interactive)
  (message
   (shell-command-to-string "curl -s ifconfig.me")))

;;; My first minor mode

(defun start--stop-tinkering-mode ()
  "Start `stop-tinkering-mode'."
  (interactive)
  (if (string-equal (buffer-name) "init.el")
      (kill-buffer))
  
  (add-hook 'find-file-hook
	    (lambda ()
	      (if (string-equal (buffer-name) "init.el")
		  (progn (message "Stop Tinkering!!")
			 (kill-buffer))))))

(defun stop--stop-tinkering-mode ()
  "Stop `stop-tinkering-mode'."
  (interactive)
  (remove-hook 'find-file-hook
	       (lambda ()
		 (if (string-equal (buffer-name) "init.el")
		     (progn (message "Stop Tinkering!!")
			    (kill-buffer))))))

(define-minor-mode stop-tinkering-mode
  "A mode to prevent you from tinkering with Emacs."
  :lighter " 🛑 tinkering"
  (if stop-tinkering-mode
      (start--stop-tinkering-mode)
    (stop--stop-tinkering-mode)))

;; (FROM REDDIT): Note that property query function are most often postfixed with -p
;; https://www.reddit.com/r/emacs/comments/4zno8p/question_simple_elisp_question_how_do_i_return/

;; Discord's webapp dynamically changes the window title based on the current channel I'm in.
;; I don't see a way to detect the window title of Discord because of this.
;; (defun discord-chat-p (window-title)
;;   ;; (or (string-match-p "Discord" window-title)
;;   ;;     (string-match-p "discord.com" window-title)))
;;   (string-match-p "Discord" window-title))

;; (defun popup-handler (app-name window-title x y w h)
;;   (when (or (equal app-name "Emacs")
;; 	    (equal app-name "Terminal"))
;;     (setq ea-paste nil))

;;   ;; set major mode
;;   (cond
;;    ((discord-chat-p window-title) (markdown-mode))
;;    ;; ...
;;    (t (markdown-mode)) ; default major mode
;;    ))

;; (add-hook 'ea-popup-hook 'popup-handler)

;;; my-functions.el ends here
