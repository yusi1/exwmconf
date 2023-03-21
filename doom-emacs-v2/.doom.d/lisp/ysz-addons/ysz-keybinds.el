;;; Keybind configurations --- ysz-keybinds.el
;;; ../.dotfiles/doom-emacs-v2/.doom.d/lisp/ysz-addons/ysz-keybinds.el -*- lexical-binding: t; -*-

;; (defmacro gremap (map func remap)
;;     "Remap keys using a macro.
;; - MAP is the map to remap the key on.
;; - FUNC is the function that you want to remap in string form, e.g: \"ibuffer\".
;; - REMAP is the function you want to remap to, can be nil
;;   (to remap to nothing, disabling the key for the function)
;;   or a function to remap to."
;;     (let ((rfunc (eval (concat "<remap> " (s-wrap func "<" ">")))))
;;       `(keymap-set ,map ,rfunc ,remap)))

;; (gremap global-map "kill-buffer" 'kill-this-buffer)

(setq mouse-drag-copy-region 'non-empty)
(setq mouse-drag-mode-line-buffer t)
(setq mouse-drag-and-drop-region-cross-program t)

(defun ysz/consult-buffer-by-prefix (&optional prefix)
  "Select a buffer prefixed by PREFIX"
  (let ((prefix (if prefix prefix (read-from-minibuffer "Buffer prefix: "))))
    (minibuffer-with-setup-hook
        (lambda ()
            (insert prefix))
      (consult-buffer))))

(defun ysz/consult-buffer-by-contains (&optional string)
  "Select a buffer that contains STRING"
  (let ((string (if string string (read-from-minibuffer "Buffer contains string: "))))
    (minibuffer-with-setup-hook
        (lambda ()
            (insert string))
      (consult-buffer))))

(map! "C-c /" (lambda () (interactive) (ysz/consult-buffer-by-prefix "F# ")))
(map! "C-c C-/" (lambda () (interactive) (ysz/consult-buffer-by-prefix)))

;; Remappings for when backspace doesn't work in TTY's.
;; (when (not window-system)
;;   (keymap-set key-translation-map "C-h" "DEL")
;;   (keymap-set key-translation-map "M-h" "C-h"))
(when (not window-system)
  (map! :map key-translation-map "C-h" "DEL")
  (map! :map key-translation-map "M-h" "C-h"))

(map!
  "s-O" 'other-window
  "s-!" 'delete-other-windows
  "s-\"" 'split-window-below
  "s-£" 'split-window-right
  "s-)" 'delete-window
  ;;;;;;;;;;;;;;;;;;;;;
  "s-F" 'find-file
  "s-B" 'switch-to-buffer
  "s-K" 'kill-this-buffer
  ;;;;;;;;;;;;;;;;;;;;;
  "s-T" 'eshell)

(defun tramp-method-p ()
  "Get the TRAMP escalation method.
If 'sudo' is in PATH, set `tramp-method' to 'sudo'.
If 'doas' is in PATH, set `tramp-method' to 'doas'.
Else, prompt for which escalation method to use."
  (cond ((executable-find "sudo")
         (setq tramp-method "sudo"))
        ((executable-find "doas")
         (setq tramp-method "doas"))
        (t (setq tramp-method (read-from-minibuffer "Escalation program: ")))))

(defun mail-as-root ()
  "View mail in `/var/mail/root' as root with RMAIL."
  (interactive)
  (let ((rmail-file-name (concat "/" (tramp-method-p) ":" "root@localhost:/var/mail/root")))
    (rmail rmail-file-name)))

(defun mail-as-user (&optional user)
  "View mail in either `/var/spool/mail/USER' or `/var/mail/USER' depending on which one exists.
If neither exist, prompt for a mail file."
  (interactive)
  (let* ((user (if user user (user-login-name)))
         (rmail-file-name (cond ((f-directory-p (concat "/var/spool/mail/" user))
                                 (concat "/var/spool/mail/" user))
                                ((f-directory-p (concat "/var/mail/" user))
                                 (concat "/var/mail/" user))
                                (t 'nil))))
    (if rmail-file-name
        (rmail rmail-file-name)
      (message (concat "No mail for " (user-login-name) ".")))))

(defun mail-as-root-multihop (&optional xfilepick xaddr xuser)
  "View mail in `/var/mail/root' as root with RMAIL.
If XFILEPICK is `t', show a prompt in `/var/mail' of the server to select a file.
If XADDR is `t', use that server address instead.
If XUSER is `t', use that username instead."
  (interactive)
  (let* ((username (if (not xuser) (read-from-minibuffer "Enter USERNAME to use: " nil) xuser))
         (address (if (not xaddr) (read-from-minibuffer "Enter IP/HOSTNAME to SSH into: " nil) xaddr))
         (host (concat username "@" address))
         (tramp-args (concat "/ssh:" host "|" "doas" ":" "root" "@" address ":"))
         (tramp-file (if (not xfilepick)
                         ;; Defaults to the file `/var/mail/root'
                         (concat tramp-args "/var/mail/root")
                       ;; Else, prompt for other mail files in `/var/mail'
                       (read-file-name "Find mail: " (concat tramp-args "/var/mail/"))))
         (remote-file tramp-file))
    ;; Run rmail using `remote-file' as the mail file to be shown.
    (rmail remote-file)))

(defun view-as-root ()
  "Use TRAMP to view the current buffer with root privileges."
  (interactive)
  (when buffer-file-name
    (find-alternate-file
     (concat "/" (tramp-method-p) ":" "root@localhost:"
             buffer-file-name))
    (message (concat "Viewing file: \"" buffer-file-name "\" with root privileges."))))

(defun view-as-root-new-buffer ()
  "Use TRAMP to view the current file with root privileges in a new buffer."
  (interactive)
  (when buffer-file-name
    (find-file
     (concat "/" (tramp-method-p) ":" "root@localhost:"
             buffer-file-name))
    (message (concat "Viewing file: \"" buffer-file-name "\" with root privileges in a new buffer."))))

(defun find-file-as-root ()
  "Find-file as root."
  (interactive)
  (find-file (concat "/" (tramp-method-p) ":" "root@localhost:"
                     (read-file-name "Find file (as root): " "/"))))

(defun dired-root ()
  "Dired as root."
  (interactive)
  (find-file (concat "/" (tramp-method-p) ":" "root@localhost:" "/")))

(defun ysz/tramp--extract-file-name (xFILE)
  (s-replace-regexp ".*\:.+?:" "" xFILE))

(defun view-as-root-remote (&optional xUSER)
  (interactive)
  (if-let ((file buffer-file-name))
   (if (file-remote-p file)
     (let* ((remote-file (ysz/tramp--extract-file-name file))
            (user (concat (if xUSER xUSER "root") "@"))
            (method (concat "/" (file-remote-p file 'method) ":"))
            (host (concat (file-remote-p file 'host) ":"))
            (full-filename (concat method user host remote-file)))
       (find-alternate-file full-filename)
       (message (concat "Viewing file: \"" full-filename "\" with root privileges.")))
     (message "This file is not remote!"))
   (message "This buffer does not contain a file!")))

(map!
  :prefix "C-c s"
  "f" 'find-file-as-root
  "<mouse-3>" 'find-file-as-root
  "s" 'view-as-root
  "S" 'view-as-root-new-buffer
  "d" 'dired-root)

(map!
  :prefix "C-c s m"
  "r" 'mail-as-root
  "u" 'mail-as-user)

(provide 'ysz-keybinds)
;;; ysz-keybinds.el ends here
