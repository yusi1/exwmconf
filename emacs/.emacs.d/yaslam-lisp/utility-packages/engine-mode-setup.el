(require 'engine-mode)

;; Default prefix is "C-x / (engine)"
(engine/set-keymap-prefix (kbd "C-x /"))
;; (define-key engine-mode-map (kbd engine/keybinding-prefix) nil)


;; Browser function for the `Librewolf' browser (only browser that works with `exwm-firefox-mode' atm for some unknown reason)
;; (setq browse-url-librewolf-program "librewolf")
;; (defun browse-url-librewolf-new-window (url &optional _)
;;   (interactive (browse-url-interactive-arg "URL: "))
;;   (setq url (browse-url-encode-url url))
;;   (let* ((process-environment (browse-url-process-environment)))
;;     (apply #'start-process
;;            (concat "librewolf --new-window" url) nil
;;            browse-url-librewolf-program
;;            (append
;; 	    '("--new-window")
;;             (list url)))))

;; (function-put 'browse-url-librewolf-new-window 'browse-url-browser-kind 'external)

;; start firefox tabs in seperate windows
(setq browse-url-firefox-new-window-is-tab nil)
(setq browse-url-firefox-arguments '("--new-window"))

;; Default browser for `engine-mode'
(setq engine/browser-function 'browse-url-firefox)

(defengine youtube
  "https://youtube.com/results?search_query=%s"
  :keybinding "y")

(defengine hnalgolia
  "https://hn.algolia.com/?dateRange=all&page=0&prefix=true&query=%s&sort=byPopularity&type=story"
  :keybinding "h")

(defengine github
  "https://github.com/search?q=%s"
  :keybinding "g")

(defengine brave
  "https://search.brave.com/search?q=%s"
  :keybinding "b")

(defengine url
  "%s"
  :keybinding "u")

(engine-mode t)

(provide 'engine-mode-setup)
