(require 'engine-mode)

;; Default prefix is "C-x / (engine)"
(engine/set-keymap-prefix (kbd "C-x /"))
(define-key engine-mode-map (kbd engine/keybinding-prefix) nil)

;; function to goto librewolf prefixed buffers
(defun ysz/consult-buffer-by-prefix (prefix)
  "Use consult to select a buffer prefixed by *PREFIX:."
  (minibuffer-with-setup-hook
      (lambda ()
        (insert (concat "*" prefix ": ")))
    (consult-buffer)))

;; search through librewolf buffers
(gkey "C-c /" (lambda ()
		(interactive)
		(ysz/consult-buffer-by-prefix "librewolf")))

;; Browser function for the `Librewolf' browser (only browser that works with `exwm-firefox-mode' atm for some unknown reason)
(setq browse-url-librewolf-program "librewolf")
(defun browse-url-librewolf-new-window (url &optional _)
  (interactive (browse-url-interactive-arg "URL: "))
  (setq url (browse-url-encode-url url))
  (let* ((process-environment (browse-url-process-environment)))
    (apply #'start-process
           (concat "librewolf --new-window" url) nil
           browse-url-librewolf-program
           (append
	    '("--new-window")
            (list url)))))

(function-put 'browse-url-librewolf-new-window 'browse-url-browser-kind 'external)

;; Default browser for `engine-mode'
(setq engine/browser-function 'browse-url-librewolf-new-window)

(defengine youtube
  "https://youtube.com/results?search_query=%s"
  :keybinding "y")

(defengine hnalgolia
  "https://hn.algolia.com/?dateRange=all&page=0&prefix=true&query=%s&sort=byPopularity&type=story"
  :keybinding "h")

(defengine github
  "https://github.com/search?q=%s"
  :keybinding "g")

(engine-mode t)

(provide 'engine-mode-setup)
