(require 'general)

(global-set-key (kbd "C-u") 'evil-scroll-up)
(global-set-key (kbd "C-c u") 'universal-argument)

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

(defun find-file-as-root ()
  "Find-file as root."
  (interactive)
  (find-file (concat "/" (tramp-method-p) ":" "root@localhost:"
                     (read-file-name "Find file (as root): " "/"))))

(defun dired-root ()
  "Dired as root."
  (interactive)
  (find-file (concat "/" (tramp-method-p) ":" "root@localhost:" "/")))

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

(general-def global-map
  :prefix "C-c s"
  "f" 'find-file-as-root
  "<mouse-3>" 'find-file-as-root
  "s" 'view-as-root
  "S" 'view-as-root-new-buffer
  "d" 'dired-root)

(provide 'ysz-keybinds)
