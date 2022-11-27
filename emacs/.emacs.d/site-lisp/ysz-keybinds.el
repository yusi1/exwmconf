;;; Keybind configurations --- ysz-keybinds.el

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
;; (use-package ysz-evil)
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
        (insert (concat prefix "# " )))
    (consult-buffer)))

(keymap-set global-map "C-c /"
	    (lambda () (interactive) (ysz/consult-buffer-by-prefix "F")))

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

(defun view-as-root ()
  "Use TRAMP to view the current buffer with root privileges."
  (interactive)
  (when buffer-file-name
    (find-alternate-file
     (concat "/sudo:root@localhost:"
	     buffer-file-name))
    (message (concat "Viewing file: \"" buffer-file-name "\" with root privileges."))))

(defun view-as-root-new-buffer ()
  "Use TRAMP to view the current file with root privileges in a new buffer."
  (interactive)
  (when buffer-file-name
    (find-file
     (concat "/sudo:root@localhost:"
	     buffer-file-name))
    (message (concat "Viewing file: \"" buffer-file-name "\" with root privileges in a new buffer."))))

(defun find-file-as-root ()
  "Find-file as root."
  (interactive)
  (find-file (concat "/sudo:root@localhost:"
		     (read-file-name "Find file (as root): " "/"))))

(defun dired-root ()
  "Dired as root."
  (interactive)
  (find-file (concat "/sudo:root@localhost:" "/")))

(general-def global-map
  :prefix "C-c s"
  "f" 'find-file-as-root
  "<mouse-3>" 'find-file-as-root
  "s" 'view-as-root
  "S" 'view-as-root-new-buffer
  "d" 'dired-root)

(provide 'ysz-keybinds)
;;; ysz-keybinds.el ends here
