;;; Keybind configurations --- ysz-keybinds.el

(if (version< emacs-version "29")
    (use-package compat :straight t :demand t))

(use-package s
  :straight t)

(use-package general
  :straight t)

(use-package ffap
  :config
  (ffap-bindings))

(use-package help
  :config
  (general-def global-map "C-c C-d" 'help-follow-symbol))

(use-package which-key
  :straight t
  :config
  (setq which-key-idle-delay 2)
  (which-key-mode))

;;;EviL mode
(use-package ysz-evil)
;;;;;;;;;;;;;;;;;;;;;;;
;;;Xah-Fly-Keys mode
;; (use-package ysz-xfk)
;;;;;;;;;;;;;;;;;;;;;;;

(defmacro gremap (map func remap)
    "Remap keys using a macro.
- MAP is the map to remap the key on.
- FUNC is the function that you want to remap in string form, e.g: \"ibuffer\".
- REMAP is the function you want to remap to, can be nil
  (to remap to nothing, disabling the key for the function)
  or a function to remap to."
    (let ((rfunc (eval (concat "<remap> " (s-wrap func "<" ">")))))
      `(keymap-set ,map ,rfunc ,remap)))

(gremap global-map "kill-buffer" 'kill-this-buffer)

(setq mouse-drag-copy-region 'non-empty)
(setq mouse-drag-mode-line-buffer t)
(setq mouse-drag-and-drop-region-cross-program t)

(defun ysz/consult-buffer-by-prefix (prefix)
  "Select a buffer prefixed by PREFIX#"
  (minibuffer-with-setup-hook
      (lambda ()
        (insert (concat prefix "# ")))
    (consult-buffer)))

(keymap-set global-map "C-c /"
            (lambda () (interactive) (ysz/consult-buffer-by-prefix "F")))

;; Remappings for when backspace doesn't work in TTY's.
(when (not window-system)
  (keymap-set key-translation-map "C-h" "DEL")
  (keymap-set key-translation-map "M-h" "C-h"))

(general-def global-map
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
  "Get the TRAMP privilege escalation method depending on the `system-type' variable.
If `system-type' is `berkeley-unix', use the `doas' method.
If `system-type' is anything else (e.g `gnu/linux') then use the `sudo' method."
  (setq tramp-method (if (not (eq system-type 'berkeley-unix))
                         "sudo"
                       "doas")))

(defun mail-as-root ()
  "View mail in `/var/mail/root' as root with RMAIL."
  (interactive)
  (let ((rmail-file-name (concat "/" (tramp-method-p) ":" "root@localhost:/var/mail/root")))
    (rmail rmail-file-name)))

(defun mail-as-user (&optional user)
  "View mail in `/var/spool/mail/USER' as USER with RMAIL.
The mail file in `/var/spool/mail' should be owned by USER for this to work."
  (interactive)
  (let ((rmail-file-name (if user
                             (concat "/var/spool/mail/" user)
                           "/var/spool/mail/yaslam")))
    (rmail rmail-file-name)))

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

(general-def global-map
  :prefix "C-c s"
  "f" 'find-file-as-root
  "<mouse-3>" 'find-file-as-root
  "s" 'view-as-root
  "S" 'view-as-root-new-buffer
  "d" 'dired-root)

(general-def global-map
  :prefix "C-c s m"
  "r" 'mail-as-root
  "u" 'mail-as-user)

(provide 'ysz-keybinds)
;;; ysz-keybinds.el ends here
